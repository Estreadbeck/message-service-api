require "rails_helper"

RSpec.describe Notification, type: :request do
  # before {@client = Client.create(source_app: "app_name")}

  it "returns ok and a 200" do
    get notifications_path
    expect(response.status).to eq(200)
    expect(response.body).to eq("ok")
  end

  it "creates a Notification" do 
  headers = {"HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(client.source_app, client.api_key)}
    client = FactoryBot.create(:client)
    # headers = { "CONTENT_TYPE" => "application/json" }
    post "/notifications",
    :params => {
      notification: {
        phone: "1234567890",
        body: "My test Message",
        source_app: "#{client.source_app}"
      }
    }, :headers => headers, xhr: true

    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:created)
  end

  xit 'renders an error status if the notification was not created' do
    # headers = { "CONTENT_TYPE" => "application/json" }
    post "/notifications",
    :params => {
      notification: {
        phone: "1234567890",
        body: "My test Message"
      }
    }, :headers => @headers, xhr: true


    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:unprocessable_entity)
  end

  xit 'sends a text via Twilio API after notification is created' do
    post "/notifications",
    :params => {
      notification: {
        phone: "1234567890",
        body: "My test Message",
        source_app: "#{@client.source_app}"
      }
    }, :headers => @headers, xhr: true

    expect(FakeSms.messages.last.num).to eq("1234567890")
  end

end



# headers: {"HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(client.source_app, client.api_key)},