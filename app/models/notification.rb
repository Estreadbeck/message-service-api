class Notification < ActiveRecord::Base
  validates_presence_of :phone, :body, :source_app
end
