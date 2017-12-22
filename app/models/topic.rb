# frozen_string_literal: true

class Topic < ApplicationRecord
  searchkick word_start: [
    :title,
    :description,
    :author_name,
    :posts_description,
    :posts_author_name
  ]
  
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :title, :description, :date, :user, presence: true
  
  def search_data
    {
      title: title,
      description: description,
      posts_description: posts.pluck(:description),
      posts_author_name: posts.includes(:user).pluck('users.name'), 
      author_name: user.name,
      date: date
    }
  end
end
