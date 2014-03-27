Mangapad::Application.routes.draw do |map|
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  match "img/(:id)", to: "chapters#test", constraints: { id: /.+/ }

  get "mangas/our_favourites" => "mangas#our_favourites"

  get "mangas" => "mangas#index"
  get "mangas/(:id)" => "mangas#redirect", constraints: { id: /\d+/ }
  resources :mangas, constraints: { id: /.+/ } do
    resources :chapters, constraints: { id: /.+/ } do
      member do
        get :jq
      end
    end
  end
  resources :chapters
  resources :pages do
    member do
      get :next, :prev
    end
  end

  
  resources :sitemap
  resources :sites
  resources :submissions
  #match "/img/(:id)", to: redirect("http://%{id}"), constraints: { id: /.+/ }
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "mangas#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
