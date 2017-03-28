require 'rails/generators'

module ApostleRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      namespace 'apostle:install'
      def copy_initializer_file
        copy_file 'initializer.rb', 'config/initializers/apostle.rb'
      end
     end
  end
end
