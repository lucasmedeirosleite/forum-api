# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { authenticate(user: user) }
  let(:topic) { FactoryBot.create(:topic, user: user) }
  
  describe 'GET #index' do
    subject(:list_posts) do
      private_get(topic_posts_path(topic_id: topic_id), token: token)
    end
    
    let(:topic_id) { topic.id }
    
    context 'when topic not found' do
      let(:topic_id) { 12_122 }
      
      it 'does not find topic' do
        list_posts
        
        expect(response).to be_not_found
      end
    end
    
    context 'when there are no posts for topic' do
      it 'returns no posts' do
        list_posts

        expect(response).to be_ok
        expect(response.body).to have_json([])
      end
    end
    
    context 'when there are posts for topic' do
      let!(:posts) { FactoryBot.create_list(:post, 3, topic: topic) }
      
      it 'returns the posts' do
        list_posts
        
        posts.each do |post|
          expect(response).to have_node(:id).with(post.id)
          expect(response).to have_node(:description).with(post.description)
          expect(response).to have_node(:date)
          expect(response).to have_node(:user_id)
          expect(response).to have_node(:topic_id).with(topic.id)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:delete_post) do
      private_delete(topic_post_path(topic_id: topic_id, id: post_id), token: token)
    end
  
    let(:topic_id) { topic.id }
  
    let!(:topic_post) { FactoryBot.create(:post, user: user, topic: topic) }
    let(:post_id) { topic_post.id }
    
    context 'when topic not found' do
      let(:topic_id) { 12_122 }
      
      it 'does not find topic' do
        delete_post
        
        expect(response).to be_not_found
      end
    end
  
    context 'when post does not exist' do
      let(:post_id) { 12_344 }
  
      it 'returns 404' do
        delete_post
  
        expect(response).to be_not_found
      end
    end
  
    context 'when post exists' do
      it 'returns 204' do
        expect do
          delete_post
        end.to change { Post.count }.by(-1)
    
        expect(response.status).to eq 204
      end
    end
  end

  describe 'POST #create' do
    subject(:create_post) do
      private_post(topic_posts_path(topic_id: topic_id), params: params, token: token)
    end
    
    let(:topic_id) { topic.id }
    
    context 'when topic not found' do
      let(:topic_id) { 12_122 }
      let(:params) { {} }
      
      it 'does not find topic' do
        create_post
        
        expect(response).to be_not_found
      end
    end
    
    context 'when post is invalid' do
      let(:params) do
        {
          description: ''
        }
      end
      
      it 'returns an invalid response' do
        create_post

        expect(response).to be_unprocessable_entity
        expect(response).to have_node(:errors)
        expect(response).to have_node(:description)
      end
    end
    
    context 'when post is valid' do
      let(:params) do
        {
          description: 'A new description'
        }
      end
      
      it 'returns a correct response' do
        expect do
          create_post
        end.to change { Topic.count }.by(1)

        expect(response).to be_created
        expect(response).to have_node(:id)
        expect(response).to have_node(:date)
        expect(response).to have_node(:description).with('A new description')
        expect(response).to have_node(:user_id)
      end
    end
  end
end