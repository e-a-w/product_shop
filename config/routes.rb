Rails.application.routes.draw do
  root "products#index"

  resources :products do
    member do
      get :confirm_destroy
      delete :destroy
    end
    collection do
      get 'department/:department', to: 'products#by_department'
    end
  end
end
