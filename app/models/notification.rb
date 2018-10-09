class Notification < ActiveRecord::Base
  validates_presence_of :phone, :body, :source_app
  validates_numericality_of :phone
  validates :phone, length: { is: 10 }
  validates :body, length: { maximum: 160 }
  belongs_to :client, foreign_key: 'source_app', primary_key: 'source_app'
end
