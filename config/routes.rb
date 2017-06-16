Rails.application.routes.draw do
devise_for :users
   root 'users#index'
   get 'users/new'
   post 'users/create'
   put 'users/:id', to: 'users#update', as: :users_update
   get 'users/list'
   get 'users/show'
   get 'users/:id/edit', to: 'users#edit' , as: :users_edit
   delete 'users/delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
