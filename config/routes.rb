Rails.application.routes.draw do
    resources :user_galleries
    resources :users
    resources :photos
    resources :galleries

    post '/user_galleries/delete', to: 'user_galleries#destroy'
    post '/set_file/:gallery_id', to: 'photos#set_file'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
