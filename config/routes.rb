Depot::Application.routes.draw do

  root "sessions#new"

  resource :products

  resource :sessions

  resource :users

  get 'products/index'=>'products#index'
  get 'products/next_step'=>'products#color_size_image'
  post 'products/pro_attr'=>'products#save_product_attr'
  get 'products/:id/edit/'=>'products#edit'
  get 'products/next_step/:id'=>'products#edit_color_size_image'
  post 'products/:id/edit'=>'products#update'

  get 'products/girl/tops'=>'products#girl_tops'
  get 'products/girl/bottoms'=>'products#girl_bottoms'
  get 'products/boy/tops'=>'products#boy_tops'
  get 'products/boy/bottoms'=>'products#boy_bottoms'

  get "store/index"
  get "users/index"
  get "users/new"
  get "sessions/new"
  get "users/create"
  get "users/edit"
  get "users/update"
  get "users/destroy"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
