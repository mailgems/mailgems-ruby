# frozen_string_literal: true

require 'digest/sha1'
require 'launchy'

module Mailgems
  class DeliveryMethod
    class InvalidOption < StandardError; end

    attr_accessor :settings

    def initialize(options = {})
      options[:host] = "https://www.mailgems.com"
      options[:api_key] ||= Mailgems.configuration.api_key
      options[:sandbox] ||= Mailgems.configuration.sandbox

      raise InvalidOption, "Api Key is required" if options[:api_key].nil?

      self.settings = options
    end

    def deliver!(mail)
      validate_mail!(mail)
      Message.new(mail, settings).send
      Launchy.open("#{settings[:host]}/sandbox") if settings[:sandbox]
    end

    private

    def validate_mail!(mail)
      if mail.smtp_envelope_from.nil? || mail.smtp_envelope_from.empty?
        raise ArgumentError, 'SMTP From address may not be blank'
      end

      if mail.smtp_envelope_to.nil? || mail.smtp_envelope_to.empty?
        raise ArgumentError, 'SMTP To address may not be blank'
      end
    end
  end
end
