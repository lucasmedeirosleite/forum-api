# frozen_string_literal: true

class Topic < ApplicationRecord
  belongs_to :user

  validates :title, :description, :date, :user, presence: true
end
