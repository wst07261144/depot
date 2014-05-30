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
  delete 'products/destroy/:id'=>'products#destroy'
  delete 'destroy/:id' => 'products#destroy'
  post '/products/shopping_cart/:product_id'=>'products#add_shopping_cart'
  get '/products/shopping_cart'=> 'products#shopping_cart_index'
  delete '/products/shopping_cart/:id'=> 'products#destroy_from_shopping_cart'

  post '/products/next_step'=> 'products#handle_img'
  post 'products/next_step/:product_id' => 'products#handle_img'

  post '/products/order'=> 'products#save_orders'
  post '/products/order/direct'=> 'products#save_order_direct'
  post '/products/order/many' => 'products#save_ordes_many'
  get '/products/order_index'=> 'products#order_index'
  delete '/products/image/:img_name' => 'products#delete_img'
  delete '/products/order/:order_id/' => 'products#delete_order'
  delete '/products/orders/:product_id/' => 'products#delete_orders'

  get '/products/orders/:item' => 'products#index'
  post '/products/girl/tops/order' => 'products#girl_tops_order'
  post '/products/boy/tops/order' => 'products#boy_tops_order'
  post '/products/girl/bottoms/order' => 'products#girl_bottoms_order'
  post '/products/boy/bottoms/order' => 'products#boy_bottoms_order'
  post '/products/all/order' => 'products#index_order'

  get '/products/buy'=> 'products#buy'

  get 'users/super_index'=> 'users#super_index'
  get 'users/super_new'=> 'users#super_new'
  get 'users/quit'=> 'users#quit'
  post 'users/super_create'=> 'users#super_create'
  patch 'users/update/:id'=>'users#update'
  delete 'users/destroy/:id'=>'users#destroy'



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
