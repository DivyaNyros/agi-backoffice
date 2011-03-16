require 'common'

namespace :patches do
  namespace :users do
    desc "re-delete deleted users to free up emails"
    task :redelete => :environment do
      deleted_users = User.find_with_deleted(:all, :conditions => "deleted_at is not null")
      deleted_users.each do |user|
        user.update_attributes!(:deleted_at => nil)
        user.destroy
      end
    end
  end
  
  namespace :events do
    desc "privatize existing events"
    task :privatize => :environment do
      Event.update_all("private = true", "private is null")
    end
  end
  
  namespace :attendees do
    desc "resubmit to icontact"
    task :resubmit_to_icontact => :environment do
      Event.upcoming.each do |event|
        puts "processing #{event.display_name}..."
        event.attendees.each do |attendee|
          puts "submitting #{attendee.name} <#{attendee.email}> to iContact"
          submit_attendee_to_icontact(attendee, event)
          sleep(1) # don't overload iContact... although it should handle it
        end
      end
    end
  end
  
  desc "Convert all email address to lower case"
  task :normalize_emails => :environment do
    puts "Normalizing user emails..."
    User.all.each do |user|
      begin
        user.update_attributes!(:email => normalize_email(user.email))
      rescue Exception => e
        puts e.message
        puts user.email
      end
    end
    
    puts "Normalizing attendee emails..."
    Attendee.all.each do |attendee|
      begin
        attendee.update_attributes!(:email => normalize_email(attendee.email))
      rescue Exception => e
        puts e.message
        puts attendee.email
      end
    end
  end
end