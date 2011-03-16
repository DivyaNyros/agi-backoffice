require 'rake'
require 'common'

namespace :event do
  desc "Submit attendees to iContact.com"
  task :submit_attendees => :environment do
    expired_events = Event.expired
    if expired_events.any?
      expired_events.each do |event|
        event_lists = {}
        lists = List.all(:conditions => ["group_name = ?", event.icontact_group])
        lists.each do |list|
          event_lists[list.state] = [list.number, list.suffix_params]
        end
      
        event.attendees.each do |attendee|
          unless event_lists[attendee.state].nil?
            submit_to_icontact(attendee, event_lists[attendee.state][1], event_lists[attendee.state][0])
          end
        end
      
        # mark event as closed
        event.close!
      end
      
      puts "Closed #{expirable_events.size} event(s)."
    else
      puts "No expired events to process."
    end
  end
  
  desc "Expire events"
  task :expire => :environment do
    expirable_events = Event.expirable
    if expirable_events.any?
      expirable_events.each do |event|
        begin
          # mark event as expired
          event.expire!
        rescue Exception => e
          puts e
        end
      end
      
      puts "Expired #{expirable_events.size} event(s)."
    else
      puts "No expirable events to process."
    end
  end
end