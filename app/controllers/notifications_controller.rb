class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :update, :destroy]
  # respond_to :json

  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
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
  end

  private
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:notification).permit(:phone, :body, :source_app)
    end
end