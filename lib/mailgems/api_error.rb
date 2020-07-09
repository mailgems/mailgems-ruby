# frozen_string_literal: true

module Mailgems
  class ApiError < StandardError
    attr_accessor :code, :message

    def initialize(code, message)
      @code = code
      @message = message
    end

    def to_s
      reason
    end

    private

    def reason
      "Code: #{code} and Message: #{message}"
    end
  end
end
