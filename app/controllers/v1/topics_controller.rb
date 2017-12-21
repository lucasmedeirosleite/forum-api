# frozen_string_literal: true

module V1
  class TopicsController < ApplicationController
    def index
      render json: current_user.topics, status: 200
    end
    
    def show
      topic = current_user.topics.find_by(id: params[:id])
      return render json: { message: 'Topic not found' }, status: 404 unless topic.present?
      
      render json: { topic: topic }, status: 200
    end
    
    def create
      topic = Topic.new(topic_params.merge(date: Time.now.utc))
      
      if(topic.save)
        render json: { topic: topic }, status: 201
      else
        render json: { errors: topic.errors.messages }, status: 422
      end
    end
    
    def update
      topic = current_user.topics.find_by(id: params[:id])
      return render json: { message: 'Topic not found' }, status: 404 unless topic.present?
      
      if topic.update(topic_params)
        render json: { topic: topic }, status: 200
      else
        render json: { errors: topic.errors.messages }, status: 422
      end
    end
    
    def destroy
      topic = current_user.topics.find_by(id: params[:id])
      return render json: { message: 'Topic not found' }, status: 404 unless topic.present?
      
      topic.destroy
      head 204
    end
    
    private
    
    def topic_params
      params
        .require(:topic)
        .permit(:title, :description, :date, :user_id)
        .merge(user_id: current_user.id)
    end
  end
end