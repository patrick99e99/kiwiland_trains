ActionController::Routing::Routes.draw do |map|

  map.resources :distances
  map.resources :routes
  map.resources :options
  map.resources :trips
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '/', :controller => :options, :action => :index

end
