# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/mail'
  end
  
  root 'home#index'
  
  devise_for :users, defaults: { format: :json }
end
