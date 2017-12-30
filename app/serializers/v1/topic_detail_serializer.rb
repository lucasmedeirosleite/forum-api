# frozen_string_literal: true

module V1
  class TopicDetailSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :date

    belongs_to :user, serializer: UserSerializer
    has_many :posts, serializer: PostSerializer

    def date
      object.date.strftime('%Y-%m-%d %H:%M:%S')
    end
  end
end
