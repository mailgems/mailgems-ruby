require "spec_helper"

RSpec.describe Mailgems::DeliveryMethod do
  before do
    Mail.defaults do
      delivery_method Mailgems::DeliveryMethod, api_key: 'test', sandbox: false
    end
  end

  it 'raises an exception if no api key passed' do
    expect { Mailgems::DeliveryMethod.new }.to raise_exception(Mailgems::DeliveryMethod::InvalidOption)
    expect { Mailgems::DeliveryMethod.new(api_key: 'test') }.to_not raise_exception
  end

  context 'passing arguments' do
    before do
      stub_request(:post, "https://api.mailgems.com/api/v1/emails").
        to_return(status: 200)
    end

    it 'raises argument error when to email not provided' do
      expect {
        Mail.deliver do
          from 'foo@example.com'
          body 'World! http://example.com'
        end
      }.to raise_error(ArgumentError)
    end

    it 'should not raise error' do
      expect {
        Mail.deliver do
          from 'foo@example.com'
          to 'bar@example.com'
          body 'World! http://example.com'
        end
      }.to_not raise_error
    end
  end
end
