# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
admin  = User.create(:email => 'admin@agi-backoffice.com', :first_name => 'AGI', :last_name => 'Admin', :password => 'password', :password_confirmation => 'password')
darius = Affiliate.create(:email => 'darius@agi-backoffice.com', :first_name => 'Darius', :last_name => 'Askaripour', :password => 'password', :password_confirmation => 'password')
hugo   = Affiliate.create(:email => 'hugo@agi-backoffice.com', :first_name => 'Hugo', :last_name => 'Ramirez', :password => 'password', :password_confirmation => 'password')

event = Event.create(
  :name => 'Weekly Meeting',
  :description => 'Weekly Meeting Description',
  :instructions => 'Come Early, Stay Late',
  :location => 'Flatotel',
  :start_date => Date.parse('2010-09-24'),
  :end_date => Date.parse('2010-09-26'),
  :start_time => Time.parse('2010-09-24 08:30'),
  :end_time => Time.parse('2010-09-26 17:00')
)

event.addresses.create(:street => '135 West 52nd Street', :unit => '(6th Ave)', :city => 'New York', :state => 'NY', :zip => '10019')
event.phone_numbers.create(:data => '(212) 887-9400', :category => 'work')
event.websites.create(:data => 'www.flatotel.com', :category => 'work')

attendee = Attendee.create(:email => 'attendee@agi-backoffice.com', :first_name => 'Event', :last_name => 'Attendee', :affiliate => darius)
attendee.events << event
attendee.phone_numbers.create(:data => '(123) 456-7890', :category => 'mobile')
