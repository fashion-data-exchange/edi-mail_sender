module FDE
  module Edi
    class Mail

      attr_accessor :from, :to, :subject, :body, :attachment, :mail

      def initialize(from, to, subject, body, attachment)
        @from = from
        @to = to
        @subject = subject
        @body = body
        @attachment = attachment
        build
      end

      def build
        from = @from
        to = @to
        subject = @subject
        body = @body
        filename = File.basename(@attachment)
        content = File.read(@attachment)

        @mail = ::Mail.new do
          from(from)
          to(to)
          subject(subject)
          body(body)
          add_file(filename: filename, content: content)
        end
      end

      def deliver!
        FDE::Edi::MailSender.smtp_account.deliver!(@mail)
      end
    end
  end
end
