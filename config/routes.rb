Rails.application.routes.draw do

  get 'segssions/create'

  get 'segssions/destroy'

  get 'setssions/create'

  get 'setssions/destroy'

  #facebook login part
  get 'auth/:provider/callback', to: 'setssions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'setssions#destroy', as: 'signout'

  resources :setssions, only: [:create, :destroy]

  #google login part
  # get 'auth/:provider/callback', to: 'segssions#create'
  # get 'auth/failure', to: redirect('/')
  # get 'signout', to: 'segssions#destroy', as: 'signout'

  # resources :segssions, only: [:create, :destroy]

  #email login part
  devise_for :authcons, :controllers => {registrations: 'registrations'}
  resources :authcons
  get 'sessions/new'

  post 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'login', to: 'sessions#create'

  root 'landpage#index'
  get 'landpage/index', to: 'landpage#index'
  get 'make_appointment', to: 'landpage#make_appointment'

  get 'dashboardpage/index', to: 'dashboardpage#index'
  get 'dashboardpage/blog_post', to: 'blog_post#post'
  post 'dashboardpage/insert'
  post 'dashboardpage/staffprofileinsert'
  post 'dashboardpage/patientprofileinsert'
  post 'dashboardpage/qnrequestinsert'
  post 'dashboardpage/message'
  post 'dashboardpage/specialistspostinsert'
  get 'dashboardpage/page'
  get 'dashboardpage/profilepatient'
  #page routes
  get 'dashboardpage/profilestaff', to: 'dashboardpage#profilestaff'
  get 'dashboardpage/profilepatient', to: 'dashboardpage#profilepatient'
  get 'dashboardpage/profilehelp', to: 'dashboardpage#profilehelp'
  get 'dashboardpage/profilemanagement', to: 'dashboardpage#profilemanagement'
  get 'dashboardpage/profilesetting', to: 'dashboardpage#profilesetting'
  get 'dashboardpage/history', to: 'dashboardpage#history'
  get 'dashboardpage/service', to: 'dashboardpage#service'
  get 'dashboardpage/servicenotification', to: 'dashboardpage#servicenotification'
  get 'dashboardpage/servicerequest', to: 'dashboardpage#servicerequest'
  get 'dashboardpage/transaction', to: 'dashboardpage#transaction'
  get 'dashboardpage/transactionrequest', to: 'dashboardpage#transactionrequest'
  get 'dashboardpage/transactionsetting', to: 'dashboardpage#transactionsetting'
  get 'dashboardpage/serviceqnsetup', to: 'dashboardpage#serviceqnsetup'
  get 'dashboardpage/profileperform', to: 'dashboardpage#profileperform'
  get 'dashboardpage/specialists_post', to: 'dashboardpage#specialists_post'

  get 'landpage/page_not_found', to: 'landpage#page_not_found'
  get '*path' => redirect('landpage/page_not_found')

  get 'application/simplecall'
  post 'application/simplecall'

  # email confirmations
  #resources :sessions, only: [:create1, :destroy1]
  # devise_for :users, controllers: { registrations: "registrations" }

  # ssget '/authcons/sign_out', to: 'devise/sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end