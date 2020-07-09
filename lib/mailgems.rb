# frozen_string_literal: true

require 'mailgems/version'

module Mailgems
  class Error < StandardError; end

  autoload :DeliveryMethod, 'mailgems/delivery_method'
  autoload :Configuration, 'mailgems/configuration'
  autoload :Mail, 'mailgems/mail'
  autoload :Message, 'mailgems/message'
  autoload :ApiError, 'mailgems/api_error'

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

require 'mailgems/railtie' if defined?(Rails::Railtie)
