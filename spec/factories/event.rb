Factory.define :event_type do |e|
  e.name "event type"
  e.description "Test event type"
end

Factory.define :event do |e|
  e.name "event"
  e.description "Test event"
  e.start_date Date.today + 14
  e.start_time "08:00"
  e.end_date Date.today + 14
  e.end_time "10:00"
  e.state "published"
  e.association :event_type
  e.private false
end