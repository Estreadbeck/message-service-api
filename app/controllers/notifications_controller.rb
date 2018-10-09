class NotificationsController < ApplicationController
  before_action :authenticate, :set_notification, only: [:show, :update, :destroy]
  include SmsTool
  # respond_to :json

  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        SmsTool.send_sms(@notification.phone, @notification.body, @notification.source_app)
        format.json { render action: 'show', status: :created, location: @notification}
      else
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    render plain: "ok"
  end

  def new
    @notification = Notification.new
  end

  def show
    render json: @notification
  end

  private
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:notification).permit(:phone, :body, :source_app)
    end

    def authenticate
      p source_app
    #   request_http_basic_authentication do |source_app, api_key|
    #     client = Client.find_by_source_app(source_app)
    #     client && client.api_key == api_key
    #   end
    end
end