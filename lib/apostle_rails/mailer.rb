module Apostle
  module Mailer

    extend ActiveSupport::Concern

    included do
      # Reset default params
      self.default_params = {}.freeze

      def initialize(method_name = nil, *args)
        super()
        @_message = Apostle::Mail.new nil
        @_apostle_known_instance_vars = (self.instance_variables.dup || [])
        process(method_name, *args) if method_name
      end

      def process(method_name, *args)
        self.send(method_name, *args)
        @_message = ActionMailer::Base::NullMail.new unless @_mail_was_called
      end

      def mail(template, variables = {}, &block)
        @_mail_was_called = true
        m = @_message
        m.template_id = template

        # Call all the procs (if any)
        class_default = self.class.default
        default_values = class_default.merge(class_default) do |k,v|
          v.respond_to?(:to_proc) ? instance_eval(&v) : v
        end

        # Handle defaults
        variables = variables.reverse_merge(default_values)

        # Set configure delivery behavior
        # TODO Enable config options such as perform_deliveries and raise_delivery_errors
        # wrap_delivery_behavior!(headers.delete(:delivery_method),headers.delete(:delivery_method_options))

        # Assign all attributes
        variables.each { |k, v| m.send("#{k}=", v) }

        # Assign all new instance vars as attributes
        all_instance_vars = self.instance_variables.dup
        @_apostle_known_instance_vars.push(:@_apostle_known_instance_vars)
        (
          all_instance_vars - @_apostle_known_instance_vars
        ).
        each do |attr|
          value = self.instance_variable_get(attr).as_json
          attr = attr.to_s.gsub('@', '')
          if m.respond_to?("#{attr}=")
            m.send("#{attr}=", value)
          else
            m.data[attr] = value
          end
        end

        m
      end
    end
  end
end
