# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :accounts, only: :show, param: :account_id
    end
  end
end
