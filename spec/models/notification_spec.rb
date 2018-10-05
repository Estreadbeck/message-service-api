require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'creation' do
    it 'can be created' do
      notification = Notification.create(phone: "801-867-5309", body: "My message", source_app: "some_app")
      expect(notification).to be_valid
    end
  end
end
