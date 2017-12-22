# frozen_string_literal: true

# frozen_string_literal

class PostsRepository
  def initialize(topic:, data_source: Post)
    @topic = topic
    @data_source = data_source
  end

  def all
    topic.posts.order(date: :desc)
  end

  def find_topic_post(id:)
    topic.posts.find_by(id: id)
  end

  def delete(post:)
    post.destroy
  end

  def save(post:)
    post.save
  end

  private

  attr_reader :topic, :data_source
end
