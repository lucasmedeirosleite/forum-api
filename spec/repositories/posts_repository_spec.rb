# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsRepository, type: :repository do
  subject(:repository) { described_class.new(topic: topic) }
  
  let(:user) { FactoryBot.create(:user) }
  let(:topic) { FactoryBot.create(:topic, user: user) }
  
  describe '#all' do
    subject(:topic_posts) { repository.all }
    
    context 'when topic does not have any posts' do
      it 'returns no topic posts' do
        expect(topic_posts).to be_empty
      end
    end
    
    context 'when topic has posts' do
      let!(:posts) { FactoryBot.create_list(:post, 3, user: user, topic: topic) }
      
      it 'returns the topic posts' do
        expect(topic_posts).to include(*posts)
      end
    end
  end
  
  describe '#create' do
    subject(:save_post) { repository.save(post: topic_post) }
    
    context 'when post is invalid' do
      let(:topic_post) { FactoryBot.build(:post, description: '', user: user, topic: topic) }
      
      it 'does not save post' do
        expect do
          save_post
        end.not_to(change { Post.count })
      end
    end
    
    context 'when post is valid' do
      let(:topic_post) { FactoryBot.build(:post, user: user, topic: topic) }
      
      it 'saves post' do
        expect do
          save_post
        end.to change { Post.count }.by(1)
      end
    end
  end
  
  describe '#delete' do
    subject(:delete_post) { repository.delete(post: post) }
    
    let!(:post) { FactoryBot.create(:post, user: user, topic: topic) }
    
    it 'deletes the existing post' do
      expect do
        delete_post
      end.to change { Post.count }.by(-1)
    end
  end
  
  describe '#find_topic_post' do
    subject(:find_topic_post) { repository.find_topic_post(id: post_id) }
    
    context 'when topic does not have post' do
      let(:post_id) { 12_123 }
      
      it 'does not return a post' do
        expect(find_topic_post).to be_nil
      end
    end
    
    context 'when topic has post' do
      let!(:post) { FactoryBot.create(:post, user: user, topic: topic) }
      let(:post_id) { post.id }
      
      it 'returns the post' do
        expect(find_topic_post).to eq post
      end
    end
  end
end