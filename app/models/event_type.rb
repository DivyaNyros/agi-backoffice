class EventType < ActiveRecord::Base
  has_many :events
  has_many :invitations

  validates_presence_of :name
end
