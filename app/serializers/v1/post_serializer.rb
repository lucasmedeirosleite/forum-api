# frozen_string_literal: true

module V1
  class PostSerializer < ActiveModel::Serializer
    attributes :id, :description, :date, :topic_id, :user

    def date
      object.date.strftime('%Y-%m-%d %H:%M:%S')
    end

    def user
      object.user
    end
  end
end
