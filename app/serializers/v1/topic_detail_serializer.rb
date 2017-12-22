# frozen_string_literal: true

module V1
  class TopicDetailSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :date, :user_id
    
    has_many :posts, serializer: PostSerializer

    def date
      object.date.to_s
    end
  end
end
