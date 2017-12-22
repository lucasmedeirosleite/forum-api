# frozen_string_literal: true

class UpdateTopic
  def initialize(repository:)
    @repository = repository
  end
  
  Operation = Struct.new(:status, :content)
  
  def call(id:, params:)
    topic = repository.find_user_topic(id: id)
    return Operation.new(:not_found) unless topic.present?
    
    if repository.save(topic: topic, params: params)
      Operation.new(:updated, topic)
    else
      Operation.new(:validation_failed, topic.errors.messages)
    end
  end
  
  private
  
  attr_reader :repository
end