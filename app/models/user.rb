class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable, 
         :validatable,
         :jwt_authenticatable, 
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
         
  has_many :topics       
  
  validates :name, presence: true
end
