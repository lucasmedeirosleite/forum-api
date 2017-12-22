# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Topics', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { authenticate(user: user) }

  describe 'POST #create' do
    subject(:create_topic) do
      private_post(topics_path, params: { topic: topic_params }, token: token)
    end

    context 'when validation fails' do
      let(:topic_params) do
        {
          title: '',
          description: ''
        }
      end

      it 'returns an invalid response' do
        create_topic

        expect(response).to be_unprocessable_entity
        expect(response).to have_node(:errors)
        expect(response).to have_node(:title)
        expect(response).to have_node(:description)
      end
    end

    context 'when validation succeeds' do
      let(:topic_params) do
        {
          title: 'A title',
          description: 'A description'
        }
      end

      it 'returns a correct response' do
        expect do
          create_topic
        end.to change { Topic.count }.by(1)

        expect(response).to be_created
        expect(response).to have_node(:id)
        expect(response).to have_node(:date)
        expect(response).to have_node(:title).with(topic_params[:title])
        expect(response).to have_node(:description).with(topic_params[:description])
        expect(response).to have_node(:user_id).with(user.id)
      end
    end
  end

  describe 'PATCH #update' do
    subject(:update_topic) do
      private_patch(topic_path(topic_id), params: { topic: topic_params }, token: token)
    end

    let!(:topic) { FactoryBot.create(:topic, user: user) }
    let(:topic_id) { topic.id }

    let(:topic_params) do
      {
        title: 'A new title',
        description: 'A new description'
      }
    end

    context 'when topic does not exist' do
      let(:topic_id) { 12_333 }

      it 'does not find the topic' do
        update_topic

        expect(response).to be_not_found
      end
    end

    context 'when validation fails' do
      let(:topic_params) do
        {
          title: '',
          description: ''
        }
      end

      it 'returns an invalid response' do
        update_topic

        expect(response).to be_unprocessable_entity
        expect(response).to have_node(:errors)
        expect(response).to have_node(:title)
        expect(response).to have_node(:description)
      end
    end

    context 'when validation succeeds' do
      it 'returns a correct response' do
        expect do
          update_topic
        end.not_to(change { Topic.count })

        expect(response).to be_ok
        expect(response).to have_node(:id)
        expect(response).to have_node(:date)
        expect(response).to have_node(:title).with(topic_params[:title])
        expect(response).to have_node(:description).with(topic_params[:description])
        expect(response).to have_node(:user_id).with(user.id)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:destroy_topic) do
      private_delete(topic_path(topic_id), token: token)
    end

    let!(:topic) { FactoryBot.create(:topic, user: user) }
    let(:topic_id) { topic.id }

    context 'when topic does not exist' do
      let(:topic_id) { 12_344 }

      it 'returns 404' do
        destroy_topic

        expect(response).to be_not_found
      end
    end

    context 'when topic exists' do
      it 'returns 204' do
        expect do
          destroy_topic
        end.to change { Topic.count }.by(-1)

        expect(response.status).to eq 204
      end
    end
  end

  describe 'GET #show' do
    subject(:show_topic) do
      private_get(topic_path(topic_id), token: token)
    end

    let!(:topic) { FactoryBot.create(:topic, user: user) }
    let(:topic_id) { topic.id }

    context 'when topic does not exist' do
      let(:topic_id) { 123_334 }

      it 'does not find the topic' do
        show_topic

        expect(response).to be_not_found
      end
    end

    context 'when topic exists' do
      it 'finds the topic' do
        show_topic

        expect(response).to be_ok
        expect(response).to have_node(:id).with(topic.id)
        expect(response).to have_node(:title).with(topic.title)
        expect(response).to have_node(:description).with(topic.description)
        expect(response).to have_node(:user_id).with(user.id)
        expect(response).to have_node(:date)
        expect(response).to have_node(:posts)
      end
    end
  end

  describe 'GET #index' do
    subject(:list_topics) do
      private_get(topics_path, token: token)
    end

    context 'when there are no topics' do
      it 'returns no topics' do
        list_topics

        expect(response).to be_ok
        expect(response.body).to have_json([])
      end
    end

    context 'when there are topics' do
      let!(:topics) { FactoryBot.create_list(:topic, 3, user: user) }

      it 'returns the topics' do
        list_topics

        topics.each do |topic|
          expect(response).to have_node(:id).with(topic.id)
          expect(response).to have_node(:title).with(topic.title)
          expect(response).to have_node(:description).with(topic.description)
          expect(response).to have_node(:date)
          expect(response).to have_node(:user_id).with(user.id)
          expect(response).not_to have_node(:posts)
        end
      end
    end
  end
end
