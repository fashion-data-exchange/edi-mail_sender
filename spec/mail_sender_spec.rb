require "spec_helper"

RSpec.describe FDE::Edi::MailSender do
  it "has a version number" do
    expect(FDE::Edi::MailSender::VERSION).not_to be nil
  end

  context 'configuration' do
    let(:attributes) do
      {
        address: 'mail.example.com',
        port: '25',
        domain: 'example.com',
        user_name: 'example@example.com',
        password: 'secret',
        authentication: 'plain',
        enable_starttls_auto: 'false'
      }
    end

    it 'yields the config block' do
      expect do |b|
        subject.configure(&b)
      end.to yield_with_args
    end

    it 'should have the configs as attributes' do
      expect(subject.config.attributes).to eq(attributes)
    end
  end

end
