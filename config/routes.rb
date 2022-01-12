Rails.application.routes.draw do
  namespace :staff do
    root "top#fuga"
  end

  namespace :admin do
    root "top#index"
  end

  namespace :customer do
    root "top#index"
  end
end
