# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  validates :description, :date, :user, :topic, presence: true
end
