Rails.application.routes.draw do

  resources :order_notes

  resources :subscribers

  devise_for :admins
  resources :orders do
    member do
      get 'payments'
    end
  end

  resources :shopping_carts do
      member do
        get 'purchase'
      end
      resources :cart_items
  end

  devise_for :users, :controllers => { sessions: 'user/sessions', registrations: 'user/registrations', passwords: 'user/passwords'}, :path_names => { :sign_in => 'login', :password => 'forgot', :confirmation => 'confirm', :unlock => 'unblock', :registration => 'register', :sign_up => 'new', :sign_out => 'logout'}
  get 'welcome/index'
  # get 'welcome/about' => 'welcome#about', as: :about
  get 'about' => 'application#about', as: :about

  get 'search' => 'application#search', as: :search
  # get 'results' => 'application#search', as: :results
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :categories

  resources :products do
    member do
      post 'add_to_session_cart'
    end
  end

  post 'purchase' => 'orders#stripe_purchase'

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
