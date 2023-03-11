Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# 顧客用
# URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'users/mypage' => 'users#show', as: 'mypage'
    get 'users/information/edit' => 'users#edit', as: 'edit_information'
    patch 'users/information' => 'users#update', as: 'update_information'
    put 'users/information' => 'users#update'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_subscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_users'

    resources :scores do
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

    resources :sites, only: [:index, :create, :update, :show]
    resources :arranges, only: [:index, :create, :update, :show]
    resources :users,  only: [:index, :show, :edit, :update]
    resources :scores, only: [:index, :show, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :comments, only: [:index, :show, :destroy]
  end

end
