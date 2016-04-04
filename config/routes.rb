Rails.application.routes.draw do
  get '/', to: 'urls#index'
  get '/:key', to: 'urls#show'
  post '/shortn', to: 'urls#create'
end
