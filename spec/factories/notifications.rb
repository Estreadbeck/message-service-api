FactoryBot.define do
  factory :notification do
    phone { "8018675309" }
    body { "My message" }
    source_app { "some_app" }
  end

  factory :second_notification, class: 'Notification' do
    phone { "8018675309" }
    body { "My message" }
    source_app { "some_app" }
  end
end
