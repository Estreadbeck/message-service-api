require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'creation' do
    it 'can be created' do
      client = Client.create(source_app: "app_name")
      notification = FactoryBot.build_stubbed(:notification)
      notification.source_app = client.source_app
      expect(notification).to be_valid
    end
  end

  describe 'validations' do
    before { @notification = FactoryBot.build_stubbed(:notification) }
    it 'can be created if valid' do
      @notification.phone = nil
      @notification.body = nil
      @notification.source_app = nil
      expect(@notification).to_not be_valid
    end

    it 'requires phone to contain string of integers' do
      @notification.phone = "thisissomerandomtext"
      expect(@notification).to_not be_valid
    end

    it 'requires phone to only be 10 characters' do
      @notification.phone = "12345678910"
      expect(@notification).to_not be_valid
    end

    it 'limits body to 160 characters max' do
      @notification.body = "word" * 500
      expect(@notification).to_not be_valid
    end
  end

  describe 'relationship' do
    it 'has a connection to a client based on the source_app attribute' do
      client = Client.create(source_app: "myapp", api_key: "mD5Rg8zXr6X1VC1RrkjUoQtt")
      notification = client.notifications.create!(phone: "9999999999", body: "Message goes here")
      expect(notification.source_app).to eq("myapp")
    end
  end
end
