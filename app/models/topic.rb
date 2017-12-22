# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :title, :description, :date, :user, presence: true
end
