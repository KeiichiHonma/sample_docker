Rails.application.routes.draw do
  root to: "home#index"
  resources :articles, only: %i(index show)
  resources :news, only: %i(index show)
  resources :contacts, only: %i(index create)
  namespace :admin do
    get "home", to: "home#index"
    resources :users, only: [:new, :create]
    resources :articles
    resources :news
    get    "login", to: "sessions#new"
    post   "login",   to: "sessions#create"
    delete "logout",  to: "sessions#destroy"
  end
  get "thanks", to: "static_pages#thanks"
  get "association", to: "static_pages#association"
  get "about", to: "static_pages#about"
  get "faq", to: "static_pages#faq"
  get "shop-list", to: "static_pages#shop_list"
  get "privacypolicy", to: "static_pages#privacypolicy"
  get "products", to: "static_pages#products"

  get "recovery-cloth", to: "static_pages#recovery_cloth"
  get "recovery-eye-pillow", to: "static_pages#recovery_eye_pillow"
  get "recovery-multi-wear", to: "static_pages#recovery_multi_wear"
  get "recovery-room-aroma-mist", to: "static_pages#recovery_room_aroma_mist"
  get "bathtime-drink", to: "static_pages#bathtime_drink"
  get "recovery-leg-fit", to: "static_pages#recovery_leg_fit"
  get "recovery-leggings", to: "static_pages#recovery_leggings"
  get "recovery-long-sleeve-tshirt", to: "static_pages#recovery_long_sleeve_tshirt"
  get "recovery-short-sleeve-tshirt", to: "static_pages#recovery_short_sleeve_tshirt"

  scope :products do
    get "recovery-cloth", to: "static_pages#recovery_cloth"
    get "recovery-eye-pillow", to: "static_pages#recovery_eye_pillow"
    get "recovery-multi-wear", to: "static_pages#recovery_multi_wear"
    get "recovery-room-aroma-mist", to: "static_pages#recovery_room_aroma_mist"
    get "bathtime-drink", to: "static_pages#bathtime_drink"
    get "recovery-leg-fit", to: "static_pages#recovery_leg_fit"
    get "recovery-leggings", to: "static_pages#recovery_leggings"
    get "recovery-long-sleeve-tshirt", to: "static_pages#recovery_long_sleeve_tshirt"
    get "recovery-short-sleeve-tshirt", to: "static_pages#recovery_short_sleeve_tshirt"
  end
  get "*path", controller: "application", action: "render_404"
end
