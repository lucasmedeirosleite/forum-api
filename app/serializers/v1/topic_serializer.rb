module V1
  class TopicSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :date, :user_id
    
    def date
      object.date.to_s
    end
  end
end