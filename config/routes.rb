Rails.application.routes.draw do
  root 'products#index'

  resources :products do
    member do
      get :confirm_destroy
      delete :destroy
    end
    collection do
      get 'department/:department', to: 'products#by_department'
      get :clearance
      get :featured
      get :search
      get :advanced_search_form
      post :advanced_search
    end
  end
end
