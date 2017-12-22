# frozen_string_literal: true

module V1
  class PostsController < ApplicationController
    before_action :render_not_found_for_topic
    
    def index
      posts = Post.where(topic_id: params[:topic_id]).order(date: :desc)
      render json: posts, status: 200
    end
    
    def destroy
      post = Post.find_by(id: params[:id])

      if post
        post.destroy
        head 204
      else
        render json: { message: 'Post not found' }, status: 404
      end
    end
    
    def create
      post = Post.new(post_params)
      if post.save
        render json: post, status: 201
      else
        render json: { errors: post.errors.messages }, status: 422
      end
    end
    
    private
    
    def render_not_found_for_topic
      topic = Topic.find_by(id: params[:topic_id])
      render json: { message: 'Topic not found' }, status: 404 if topic.blank?
    end
    
    def post_params
      params
        .require(:post)
        .permit(:description, :date, :user_id, :topic_id)
        .merge(user_id: current_user.id, topic_id: params[:topic_id], date: Time.now.utc)
    end
  end
end