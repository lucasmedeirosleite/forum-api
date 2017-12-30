# frozen_string_literal: true

module V1
  class TopicSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :date, :posts_count
    belongs_to :user, serializer: UserSerializer

    def date
      object.date.strftime('%Y-%m-%d %H:%M:%S')
    end

    def posts_count
      object.posts.count
    end
  end
end
