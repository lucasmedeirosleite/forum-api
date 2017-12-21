# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/mail' if Rails.env.development?

  root 'home#index'

  devise_for :users, defaults: { format: :json }
end
