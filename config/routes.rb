OneSixtyOne::Application.routes.draw do
 
 root to: "static_pages#home"
   

  resources :schools, only: [:new, :create, :index]

  #Here I am using nested routes to display all of the users/items for each school and to create 
  #a new user.

  resources :schools, only: [:show] do
    resources :users, only: [:index, :new, :create]
  end

  resources :schools, only: [:show] do
    resources :items, only: :index
  end 

  #wont need the school to access/edit/update/delete a specific user, just going thru
  #current_user.

  resources :users, only: [:show, :edit, :update, :delete] do
    member do
        get :following, :followers, :personal_item, :feed
      end
  end
  
  #again I can get to the school and user from current_user here so i do not need nesting
  #for items.
  
  resources :items, only: [:create, :new, :edit, :show, :update, :delete] do
    resources :reactions, only: [:create, :destroy]
  end


  resources :relationships, only: [:create, :destroy]


#I am using this to create/destroy my want so I have access to the item

  resources :items, only: [:show] do
    resources :wants, only: [:create] do
    end
  end

#I am using this for adding votes so I have access to the item

resources :items, only: [:show] do
    resources :votes, only: [:create] do
    end
end

#I am using this to update my already existing want

  resources :wants, only: [:update, :destroy] do
      resources :personals, only: [:create]
  end

  
  resources :sessions, only: [:new, :create, :destroy]

  match '/about',  to: 'static_pages#about'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

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
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
