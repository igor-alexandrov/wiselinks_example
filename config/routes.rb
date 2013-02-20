WiselinksExample::Application.routes.draw do
  get 'catalog' => 'home#catalog'
  get 'redirect' => 'home#redirect'
  
  root :to => 'home#index'
end
