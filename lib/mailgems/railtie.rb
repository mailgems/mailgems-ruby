# frozen_string_literal: true

module Mailgems
  class Railtie < Rails::Railtie
    initializer 'mailgems.add_delivery_method' do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method(
          :mailgems,
          Mailgems::DeliveryMethod
        )
      end
    end
  end
end
