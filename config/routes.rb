Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'

  resources :items do
    collection do
      get 'purchase/:id' => 'items#purchase', as: 'purchase'
      post 'pay/:id'=> 'items#pay', as: 'pay'
      get  'done'=> 'items#done', as: 'done'
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :users, only: [:index, :show, :edit, :update] do
    collection do 
      get 'done'
    end
  end
  resources :cards, only: [:new, :create, :show] do
    collection do
      post 'delete', to: 'cards#delete'
    end
    member do
      get 'confirmation'
    end
  end
end
