# frozen_string_literal: true

module V1
  class PostSerializer < ActiveModel::Serializer
    attributes :id, :description, :date, :user_id, :topic_id

    def date
      object.date.to_s
    end
  end
end
