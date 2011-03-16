ActionController::Routing::Routes.draw do |map|
  map.devise_for :users

  map.root :controller => 'dashboard', :action => 'index'
  
  map.dashboard 'dashboard', :controller => 'dashboard', :action => 'index'
  
  map.resources :events, :collection => { :search => :get, :closed => :get, :all => :get,:change_state_option =>[:get] }, :member => { :checkin => [:post, :get], :export => [:get] }
  
  map.resources :attendees, :collection => { :search => :get }, :member => { :check_in => :put, :purchase => :put, :no_show => :put } do |attendee|
    attendee.resources :activities, :only => [:create, :destroy]
  end

  map.resources :affiliates, :collection => { :search => :get }
  map.resources :invitations, :collection => { :search => :get }
  # map.resend_welcome 'affiliates/:email/resend', :controller => 'affiliates', :action => 'resend'
  map.resources :users, :collection => { :deleted => :get }, :member => { :restore => :put, :permanently_delete => :delete }
  map.resources :lists
  map.resources :sources
  map.resources :event_types
  
  map.namespace :api do |api|
    # api.resources :affiliates
    api.resources :attendees
    api.resources :invitations
    api.resources :sources
    api.resources :events, :collection => { :map => :get }
    
    api.events_in_state '/events/in/:state', :controller => :events, :action => :in
    api.formatted_events_in_state '/events/in/:state.:format', :controller => :events, :action => :in
    api.registration_events '/events/code/:invite_code.:format', :controller => :events, :action => :registration_events
    
    api.connect ':controller/:action/:id'
    api.connect ':controller/:action/:id.:format'
  end
  
  # TODO: refactor these into a checkin_controller or event_registrations_controller
  map.with_options :controller => 'events' do |events|
    events.do_confirm '/events/:id/attendee/:attendee_id/confirm', :action => 'do_confirm'
    events.do_cancel '/events/:id/attendee/:attendee_id/cancel', :action => 'do_cancel'
  	events.do_checkin '/events/:id/attendee/:attendee_id/checkin', :action => 'do_checkin'
    events.do_noshow '/events/:id/attendee/:attendee_id/noshow', :action => 'do_noshow'
    events.do_otf '/events/:id/attendee/:attendee_id/otf', :action => 'do_otf'
    events.do_purchase '/events/:id/attendee/:attendee_id/purchase', :action => 'do_purchase'
    events.reschedule '/events/:id/attendee/:attendee_id/reschedule', :action => 'reschedule'
  end
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
