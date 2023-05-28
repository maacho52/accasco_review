Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# 顧客用
# URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    put 'users/information' => 'users#update'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_subscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_users'
    get 'users/scores' => 'users#scores_index', as: 'user_scores'
    get 'users/review' => 'users#reviews_index', as: 'user_reviews'
    #post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'

    resources :scores do
      collection do
        get 'search'
      end

      resources :reviews do
        resources :comments, only: [:index, :new, :create, :delete, :show]
      end
    end

  end




# 管理者用
# URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'homes#top'

    resources :sites
    resources :arranges
    resources :users,  only: [:index, :show, :edit, :update]
    resources :scores, only: [:index, :show, :edit, :update, :destroy] do
      resources :reviews, only: [:index, :show, :edit, :update, :destroy] do
        resources :comments, only: [:index, :show, :destroy]
      end
    end
  end

end
