require "spec_helper"

RSpec.describe Mailgems::Mail do
  before do
    Mail.defaults do
      delivery_method Mailgems::DeliveryMethod, api_key: 'test', sandbox: false
    end
  end

  it 'raises an exception if no api key passed' do
    expect { Mailgems::Mail.new() }.to raise_exception(Mailgems::Mail::InvalidOption)
    expect { Mailgems::Mail.new(api_key: 'test') }.to_not raise_exception
  end

  describe '#send_email' do
    context 'error' do
      before do
        stub_request(:post, "https://api.mailgems.com/api/v1/emails").
          to_return(body: { 'message' => 'This is an error' }.to_json, status: 404)
      end

      it 'raises exception when api returns status other than 200' do
        expect {
          Mailgems::Mail.new(api_key: 'test').send_mail({})
        }.to raise_error(Mailgems::ApiError)
      end
    end

    context 'success' do
      before do
        stub_request(:post, "https://api.mailgems.com/api/v1/emails").
          to_return(body: { 'message' => 'This is a success' }.to_json, status: 200)
      end

      it 'raises exception when api returns status other than 200' do
        expect {
          Mailgems::Mail.new(api_key: 'test').send_mail({})
        }.to_not raise_error
      end
    end
  end
end
