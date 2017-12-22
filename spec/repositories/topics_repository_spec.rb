# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopicsRepository, type: :repository do
  subject(:repository) { described_class.new(user: user) }
  
  let(:user) { FactoryBot.create(:user) }
  
  describe '#all' do
    subject(:list_topics) { repository.all }
    
    context 'when there are no topics' do
      it 'returns no topics' do
        expect(list_topics).to be_empty
      end
    end
    
    context 'when there are topics' do
      let!(:topics) { FactoryBot.create_list(:topic, 3, user: user) }
      
      it 'returns the existing topics' do
        expect(list_topics).to include(*topics)
      end
    end
  end
  
  describe '#find_user_topic' do
    subject(:find_topic) { repository.find_user_topic(id: topic.id) }
    
    context 'when user created a topic' do
      let(:topic) { FactoryBot.create(:topic, user: user) }
      
      it 'returns the topic' do
        expect(find_topic).to eq(topic) 
      end
    end
    
    context 'when user did not create a topic' do
      let(:topic) { FactoryBot.create(:topic) }
      
      it 'does not return a topic' do
        expect(find_topic).to be_nil
      end
    end
  end

  describe '#delete' do
    subject(:delete_topic) { repository.delete(topic: topic) }
    
    let!(:topic) { FactoryBot.create(:topic, user: user) }
  
    it 'deletes the topic' do
      expect {
        delete_topic
      }.to change { Topic.count }.by(-1)
    end
  end
  
  describe '#save' do
    subject(:save_topic) { repository.save(topic: topic, params: params) }
    
    context 'when creating new topic' do
      let(:params) { {} }
      let(:topic) { Topic.new(topic_params) }
      
      context 'with valid values' do
        let(:topic_params) do
          {
            title: 'A title',
            description: 'A description',
            date: Time.now.utc,
            user_id: user.id
          }
        end
        
        it 'creates a new topic' do
          expect {
            save_topic
          }.to change { Topic.count }.by(1)
        end
      end
      
      context 'with invalid values' do
        let(:topic_params) do
          {
            title: '',
            description: ''
          }
        end
        
        it 'does not create a topic' do
          expect {
            save_topic
          }.not_to change { Topic.count }
        end
      end
    end
    
    context 'when updating a topic' do
      let!(:topic) { FactoryBot.create(:topic, user: user) }
        
      context 'with valid values' do
        let(:params) do
          {
            title: 'A new title',
            description: 'A new description'
          }
        end
        
        it 'updates the existing project' do
          expect {
            save_topic
          }.not_to change { Topic.count }
          
          topic = Topic.last
          
          expect(topic.title).to eq('A new title')
          expect(topic.description).to eq('A new description')
        end
      end
      
      context 'with invalid values' do
        let(:params) do
          {
            title: '',
            description: ''
          }
        end
        
        it 'does not update the existing project' do
          expect {
            save_topic
          }.not_to change { Topic.count }
          
          topic = Topic.last
          
          expect(topic.title).not_to eq('')
          expect(topic.description).not_to eq('')
        end
      end
    end
  end
end