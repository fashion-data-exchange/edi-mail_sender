require "spec_helper"

RSpec.describe FDE::Mail do

  let(:from) { 'test.edi@example.com' }
  let(:to) { 'edi@example.com' }
  let(:mail_subject) { 'New EDI File' }
  let(:body) { 'EDI FILE' }
  let(:attachment) { './spec/fixtures/test.edi' }

  subject {
    described_class.new(from, to, mail_subject, body, attachment)
  }


  describe 'new' do
    it 'should have a from address' do
      expect(subject.from).to eq(from)
    end

    it 'should have a to address' do
      expect(subject.to).to eq(to)
    end

    it 'should have a subject' do
      expect(subject.subject).to eq(mail_subject)
    end

    it 'should have a body' do
      expect(subject.body).to eq(body)
    end

    it 'should have an attachment' do
      expect(subject.attachment).to eq(attachment)
    end
  end

  describe 'build' do
    it 'should create a Mail::Message object' do
      expect(subject.build).to be_a(Mail::Message)
    end
  end

  describe 'deliver!' do
    it 'should deliver the mail and return a Mail::SMTP Object' do
      allow(subject).to receive(:deliver!) { FDE::MailSender.smtp_account }
      expect(subject.deliver!).to be_a(Mail::SMTP)
    end
  end
end
