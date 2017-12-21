class Topic < ApplicationRecord
  belongs_to :user
  
  validates :title, :description, :date, :user, presence: true
end
