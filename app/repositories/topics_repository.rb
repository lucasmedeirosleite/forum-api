# frozen_string_literal: true

class TopicsRepository
  def initialize(user: nil, data_source: Topic)
    @user = user
    @data_source = data_source
  end

  def all(term: '*', page: 1, per: 100)
    data_source.search(term,
                       page: page, 
                       per_page: per, 
                       order: { date: :desc },
                       misspellings: { below: 5 },
                       fields: ['title^10', 
                                'description^8', 
                                'posts_description^6',
                                'author_name^4',
                                'posts_author_name^2'])
  end

  def find_user_topic(id:)
    return if user.blank?
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
