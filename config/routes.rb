WebInfo2::Application.routes.draw do

  root "main#parse_route"

  # get 'home/index'
  #root 'home#showHome'
  get '/home/track_image', to:'playlist_musics#track_image'

  get '/home', to: 'home#showHome'
  match ':controller(/:action(/:id))', :via => :get
  post '/sign_up', to: 'home#sign_up'
  post '/sign_out', to: 'home#sign_out'
  post '/login', to: 'home#login'
  get '/sign_out', to: 'home#sign_out'
  get '/get_tracks', to: 'musics#get_tracks'

# Show users profile, and let's him update.
  get '/user_profile', to: 'profile#showProfile' 
  get '/go_home', to: 'home#showHome'
  post '/newTrack', to: 'profile#newTrack'
  post '/update_profile', to: 'profile#updateProfile'
  post '/update_details', to: 'profile#updateDetails'
  get '/other_profile', to: 'profile#showOther'
  post'/unfollow_user', to: 'profile#unfollow'
  post '/follow_user', to: 'profile#follow'
  get '/followers', to: 'profile#showFollowers'

# Do collaborations here.
  post '/collaborate', to: 'collaboration#coRequest'
  get '/showAllRequests', to: 'collaboration#showRequests'
  post '/acceptRequester', to: 'collaboration#acceptRequest'

# Changing donations email
  post '/update_payment_email', to: 'profile#change_payment_email'


# Searching...
  get '/search', to: 'application#search_results'  

# When user presses play
  post '/play', to: 'musics#play'

# When users want to comment on music
  get '/comments/music', to: 'musics#comments'
  post '/add_music_comment', to: 'musics#add_comment'

# When the user wants to delete their music
  post '/delete_medium', to: 'musics#delete_medium'
  post '/editTrack', to: 'musics#edit_track'

  # Get's user's playlist
  get '/playlist', to: 'playlist_musics#get_playlist'

  # Adds a song to the user's playlist
  post '/add_song', to: 'playlist_musics#add_song'

  # Gets a track image given a track id
  get '/track_image', to: 'playlist_musics#track_image'

  resources :medium_comments

  resources :media

  resources :ratings

  resources :playlist_musics

  resources :music_albums

  resources :musics

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
