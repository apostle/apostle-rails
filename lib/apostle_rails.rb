require 'apostle'
require "apostle_rails/version"
require "apostle_rails/mailer"

if defined?(Rails) && Rails.env.test?
  Apostle.configure do |config|
    config.deliver = false
  end
end
