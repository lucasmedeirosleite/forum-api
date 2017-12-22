# frozen_string_literal: true

class TopicsRepository
  def initialize(user:, data_source: Topic)
    @user = user
    @data_source = data_source
  end
  
  def all
    data_source.all.order(date: :desc)
  end
  
  def find_user_topic(id:)
    user.topics.find_by(id: id)
  end
  
  def save(topic:, params: {})
    if topic.new_record?
      topic.save
    else
      topic.update params
    end
  end
  
  def delete(topic:)
    topic.destroy
  end
  
  private
  
  attr_reader :user, :data_source
  delegate :find_by, to: :data_source
end