class Application < ActiveRecord::Base

  belongs_to :user
  has_many :events

  validates :name, presence: true, length: { minimum: 2 }
  validates :url, presence: true 
  # validates :url, :url => true
  
end