Rails.application.routes.draw do
  get 'users/index'

  devise_for :users

  # FIXME: restructure these routes by "resource" and "scope"
  get     'cups'              => "cups#index",      as: :cups
  post    'cups'              => "cups#create"
  get     'cups/new'          => "cups#new",        as: :new_cup
  get     'cups/:cup_id/edit' => "cups#edit",       as: :edit_cup
  get     'cups/:cup_id'      => "cups#show",       as: :cup
  patch   'cups/:cup_id'      => "cups#update"
  put     'cups/:cup_id'      => "cups#update"
  delete  'cups/:cup_id'      => "cups#destroy",    as: :delete_cup

  get     'teams/:cup_id'       => "teams#index",     as: :teams
  post    'teams/:cup_id'       => "teams#create"
  get     'teams/new/:cup_id'   => "teams#new",       as: :new_team
  get     'teams/:team_id/edit' => "teams#edit",      as: :edit_team
  get     'teams/:team_id/show' => "teams#show",      as: :team
  patch   'teams/:team_id/show' => "teams#update"
  put     'teams/:team_id/show' => "teams#update"
  delete  'teams/:team_id'      => "teams#destroy",   as: :delete_team

  get     'matches/:cup_id'             => "matches#index",   as: :matches
  post    'matches/:cup_id'             => "matches#create"
  get     'matches/new/:cup_id'         => "matches#new",     as: :new_match
  get     'matches/:match_id/edit'      => "matches#edit",    as: :edit_match
  get     'matches/:match_id/show'      => "matches#show",    as: :match
  patch   'matches/:match_id/show'      => "matches#update"
  put     'matches/:match_id/show'      => "matches#update"
  delete  'matches/:match_id'           => "matches#destroy", as: :delete_match

  get     'predictions/:cup_id'             => "predictions#index",   as: :predictions
  post    'predictions/:cup_id'             => "predictions#create"
  get     'predictions/new/:cup_id'         => "predictions#new",     as: :new_prediction
  get     'predictions/:prediction_id/edit' => "predictions#edit",    as: :edit_prediction
  get     'predictions/:prediction_id/show' => "predictions#show",    as: :prediction
  patch   'predictions/:prediction_id/show' => "predictions#update"
  put     'predictions/:prediction_id/show' => "predictions#update"
  delete  'predictions/:prediction_id'      => "predictions#destroy", as: :delete_prediction

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'cups#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
