# frozen_string_literal: true

module V1
  class TopicsController < ApplicationController
    def index
      render json: repository.all(page: params[:page], per: params[:per]), status: 200
    end

    def show
      topic = repository.find_by(id: params[:id])
      if topic
        render json: topic, status: 200
      else
        not_found
      end
    end

    def create
      topic = Topic.new(topic_params.merge(date: Time.now.utc))

      if repository.save(topic: topic)
        render json: topic, status: 201
      else
        render json: { errors: topic.errors.messages }, status: 422
      end
    end

    def update
      result = UpdateTopic.new(repository: repository).call(id: params[:id], params: topic_params)

      case result.status
      when :not_found
        not_found
      when :validation_failed
        render json: { errors: result.content }, status: 422
      else
        render json: result.content, status: 200
      end
    end

    def destroy
      topic = repository.find_user_topic(id: params[:id])
      if topic
        repository.delete(topic: topic)
        head 204
      else
        not_found
      end
    end

    private

    def repository
      @_repository ||= TopicsRepository.new(user: current_user)
    end

    def topic_params
      params
        .require(:topic)
        .permit(:title, :description, :date, :user_id)
        .merge(user_id: current_user.id)
    end

    def not_found
      render json: { message: 'Topic not found' }, status: 404
    end
  end
end
