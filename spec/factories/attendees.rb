Factory.define :attendee do |a|
  a.first_name 'Will'
  a.last_name 'Attend'
  a.email { Factory.next(:email) }
end