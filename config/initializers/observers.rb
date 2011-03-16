ActiveRecord::Base.observers = :user_observer, :affiliate_observer, :event_registration_observer, :invitation_observer
ActiveRecord::Base.instantiate_observers

class ActiveRecord::Observer
  def logger
    RAILS_DEFAULT_LOGGER
  end
end