Rails.application.routes.draw do
  get '/:key', to: 'urls#show'
  post '/shortn', to: 'urls#create'
end
