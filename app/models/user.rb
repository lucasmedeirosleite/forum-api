# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :registerable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :name, presence: true
end
