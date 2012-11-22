WiselinksExample::Application.routes.draw do
  match '/catalog' => 'home#catalog'
  root :to => 'home#about'
end
