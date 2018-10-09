FactoryBot.define do
  factory :notification do
    phone { "8018675309" }
    body { "My message" }
    source_app { "an_app" }
  end

  factory :second_notification, class: 'Notification' do
    phone { "5555555555" }
    body { "another message" }
    source_app { "some_app" }
  end

  factory :third_notification, class: 'Notification' do
    phone { "4444444444" }
    body { "different message" }
    source_app { "some_other_app" }
  end
end
