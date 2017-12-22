# frozen_string_literal: true

module V1
  class PostsController < ApplicationController
    before_action :render_not_found_for_topic

    def index
      render json: posts_repo.all, status: 200
    end

    def destroy
      post = posts_repo.find_topic_post(id: params[:id])
      if post
        posts_repo.delete(post: post)
        head 204
      else
        not_found
      end
    end

    def create
      post = Post.new(post_params)
      if posts_repo.save(post: post)
        render json: post, status: 201
      else
        render json: { errors: post.errors.messages }, status: 422
      end
    end

    private

    def render_not_found_for_topic
      not_found('Topic') if current_topic.blank?
    end

    def posts_repo
      @_posts_repo ||= PostsRepository.new(topic: current_topic)
    end

    def topics_repo
      @_topics_repo ||= TopicsRepository.new(user: current_user)
    end

    def current_topic
      @_current_topic ||= topics_repo.find_by(id: params[:topic_id])
    end

    def post_params
      params
        .require(:post)
        .permit(:description, :date, :user_id, :topic_id)
        .merge(user_id: current_user.id, topic_id: current_topic.id, date: Time.now.utc)
    end

    def not_found(model = 'Post')
      render json: { message: "#{model} not found" }, status: 404
    end
  end
end
