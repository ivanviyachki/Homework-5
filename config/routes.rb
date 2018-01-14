Rails.application.routes.draw do
  resources :rsas
  resources :messages
	  
	post '/rsas', to: 'rs_as#create'
	get '/rsas/:id', to: 'rs_as#show'

	post '/rsas/:id/encrypt_messages', to: 'messages#create'
	get '/rsas/:id/encrypt_messages/:mid', to: 'messages#show'

	post '/rsas/:id/decrypt_messages', to: 'messages#decrypt'
end
