# frozen_string_literal: true

module Mailgems
  class Message
    attr_reader :mail, :api_key, :sandbox
    ERROR_MSG = '%s configuration must be given'

    def initialize(mail, settings)
      @mail = mail
      @api_key = settings[:api_key]
      @sandbox = settings[:sandbox]

      raise ArgumentError, ERROR_MSG % 'Api key' unless @api_key
    end

    def send
      Mail.new(api_key: api_key).send_mail(params)
    end

    private

    def params
      {
        recipients: recipients, from_email: from_email, from_name: from_name,
        subject: subject, content: content, server: server, cc: cc, bcc: bcc,
        attachments: attachments, template: template, is_test: sandbox
      }
    end

    def recipients
      mail.to.map do |to|
        {
          email: to,
          attributes: mail.header['merge_data']&.unparsed_value
        }
      end
    end

    def from_email
      mail[:from].addrs.first.address
    end

    def from_name
      mail[:from].addrs.first.name
    end

    def subject
      mail.subject
    end

    def content
      return mail.html_part.decoded if mail.html_part

      mail.text_part&.decoded
    end

    def template
      mail.body&.raw_source
    end

    def server
      mail.header['server']&.value
    end

    def cc
      mail[:cc]&.addrs&.map(&:address)
    end

    def bcc
      mail[:bcc]&.addrs&.map(&:address)
    end

    def attachments
      mail.attachments.map do |attachment|
        if inline?(attachment)
          inline_attachment_body(attachment)
        else
          attachment_body(attachment)
        end
      end.compact
    end

    def inline_attachment_body(attachment)
      {
        filename: attachment.filename,
        content: Base64.strict_encode64(attachment.decoded),
        content_id: attachment['Content-ID'].element.message_ids.first,
        inline: true
      }
    end

    def attachment_body(attachment)
      {
        filename: attachment.filename,
        content: Base64.strict_encode64(attachment.decoded)
      }
    end

    def inline?(attachment)
      attachment.content_disposition.starts_with? 'inline'
    end
  end
end
