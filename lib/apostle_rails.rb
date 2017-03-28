require 'apostle'
require 'apostle_rails/version'
require 'apostle_rails/mailer'
require 'generators/apostle_rails/install_generator'

if defined?(Rails) && Rails.env.test?
  Apostle.configure do |config|
    config.deliver = false
  end
end
