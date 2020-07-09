# frozen_string_literal: true

require 'httparty'

module Mailgems
  class Mail
    class InvalidOption < StandardError; end
    include HTTParty

    base_uri 'https://api.mailgems.com/api'
    attr_accessor :api_key, :api_version

    def initialize(opts = {})
      @api_key = opts[:api_key]
      @api_version = opts[:api_version] || 'v1'

      raise InvalidOption, "Api Key is required" if opts[:api_key].nil?
    end

    def send_mail(params)
      response = self.class.post("/#{api_version}/emails",
                                 body: params.to_json, headers: headers)

      response_code = response.code
      response_hash = response.parsed_response

      raise_exception(response_code, response_hash) unless response_code == 200

      response_hash
    end

    private

    def headers
      {
        'Content-Type': 'application/json',
        'X-Api-Key': api_key
      }
    end

    def raise_exception(code, hash)
      raise Mailgems::ApiError.new(code, hash['message'])
    end
  end
end
