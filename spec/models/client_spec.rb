require 'rails_helper'

RSpec.describe Client, type: :model do
  before do
    @client = FactoryBot.build_stubbed(:client)
  end
    
  describe 'creation' do
    it 'can be created' do
      expect(@client).to be_valid
    end
  end

  describe 'validations' do
    it 'can not be created if not valid' do
      @client.source_app = nil
      @client.api_key = nil
      expect(@client).to_not be_valid
    end

    it 'has a unique source_app' do
      first_client = Client.create(source_app: "app_name", api_key: "I384fHtD1h9XZvs4fGPJUgtt")
      duplicate_client = Client.create(source_app: "app_name", api_key: "I384fHtD1h9XZvs4fGPJUgtt")
      expect(duplicate_client).to_not be_valid
    end
  end

  describe 'callbacks' do
    it 'will have an api_key automatically assigned at creation' do
      client = Client.create(source_app: "app_name")
      expect(client.api_key).to_not be_nil
    end
  end
end