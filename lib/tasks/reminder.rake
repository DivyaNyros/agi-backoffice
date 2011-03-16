require 'rake'
require "common"

namespace :reminder do
  desc "Remind attendees of weekly meeting."
  task :wm_remind => :environment do
    events = Event.upcoming.find(:all, :conditions => {:icontact_group => "WM"})
    if events.any?
      sent_count = 0
      today      = get_eastern_time_now.to_date

      events.each do |event|
        event_date = get_event_eastern_time(event).to_date
        
        case
        when today == event_date - 1.day
          event.attendees.each do |attendee|
            AttendeeMailer.deliver_wm_reminder(attendee, event)
            log_reminder(attendee, "Sent reminder for '#{event.display_name}'")
            sent_count += 1
          end
        end
      end
      
      puts "Sent #{sent_count} reminders for weekly meetings."
    else
      puts "No event reminders to send for weekly meetings."
    end
  end

  desc "Remind of 3 days meeting."
  task :threedm_remind => :environment do
    events = Event.upcoming.find(:all, :conditions => {:icontact_group => "3D"})
    if events.any?
      sent_count = 0
      today      = get_eastern_time_now

      events.each do |event|
        event_date = get_event_eastern_time(event).to_date
        
        case
        when today == event_date - 2.weeks
          event.attendees.each do |attendee|
            AttendeeMailer.deliver_threedm_second_reminder(attendee, event)
            log_reminder(attendee, "Sent 2 week reminder for '#{event.display_name}'")
            sent_count += 1
          end
        when today == event_date - 1.week
          event.attendees.each do |attendee|
            AttendeeMailer.deliver_threedm_third_reminder(attendee, event)
            log_reminder(attendee, "Sent 1 week reminder for '#{event.display_name}'")
            sent_count += 1
          end
        when today == event_date - 2.days
          event.attendees.each do |attendee|
            AttendeeMailer.deliver_threedm_fourth_reminder(attendee, event)
            log_reminder(attendee, "Sent 2 day reminder for '#{event.display_name}'")
            sent_count += 1
          end
        end
      end
      
      puts "Sent #{sent_count} reminders for 3-Day meetings."
    else
      puts "No event reminders to send for 3-Day meetings."
    end
  end
end

def log_reminder(attendee, message)
  # log activity on the attendee
  attendee.activities.create(
    :actor    => attendee.affiliate,
    :category => 'email',
    :data     => message,
    :system   => true
  )
end