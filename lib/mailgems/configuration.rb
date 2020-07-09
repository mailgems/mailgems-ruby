# frozen_string_literal: true

module Mailgems
  class Configuration
    attr_accessor :api_key, :sandbox, :api_version

    def initialize
      @api_key = nil
      @sandbox = false
      @api_version = 'v1'
    end
  end
end
