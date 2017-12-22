# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateTopic, type: :service do
  subject(:service) { UpdateTopic.new(repository: repository) }

  let(:repository) { double(:topics_repository) }

  describe '#call' do
    subject(:perform_update) { service.call(id: topic_id, params: params) }

    let(:topic_id) { 123 }
    let(:topic) { FactoryBot.create(:topic, id: topic_id) }

    context 'when topic does not exist' do
      let(:params) { {} }

      before do
        allow(repository).to receive(:find_user_topic).with(id: topic_id).and_return(nil)
      end

      it 'returns no topic' do
        result = perform_update

        expect(result.status).to eq(:not_found)
      end
    end

    context 'when topic validation failed' do
      let(:params) do
        {
          title: '',
          description: ''
        }
      end

      before do
        allow(repository).to receive(:find_user_topic).with(id: topic_id).and_return(topic)
        allow(repository).to receive(:save).with(topic: topic, params: params).and_return(false)
      end

      it 'does not update the topic' do
        result = perform_update

        expect(result.status).to eq(:validation_failed)
      end
    end

    context 'when topic is valid' do
      let(:params) do
        {
          title: 'A new title',
          description: 'A new description'
        }
      end

      before do
        allow(repository).to receive(:find_user_topic).with(id: topic_id).and_return(topic)
        allow(repository).to receive(:save).with(topic: topic, params: params).and_return(true)
      end

      it 'updated the topic' do
        result = perform_update

        expect(result.status).to eq(:updated)
      end
    end
  end
end
