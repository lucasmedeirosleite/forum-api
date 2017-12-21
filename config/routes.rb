# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/mail' if Rails.env.development?

  root 'home#index'

  devise_for :users, defaults: { format: :json }

  api_version(module: 'V1',
              header: { name: 'Accept', value: 'application/vnd.forum.com; version=1' }) do

    resources :topics, only: %i[create update destroy index show], defaults: { format: :json }
  end
end
