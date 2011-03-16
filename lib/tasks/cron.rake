desc "daily cron task that gets run by heroku"
task :cron => :environment do
  Rake::Task['db:backup'].invoke
  Rake::Task['db:purge'].invoke
  Rake::Task['run_post_event_processes'].invoke  
  Rake::Task['send_event_reminders'].invoke
end  

desc "run post-event processing"
task :run_post_event_processes do
  puts "Running post-event processes..."
  Rake::Task['event:expire'].invoke
  Rake::Task['event:submit_attendees'].invoke
end

desc "send event reminder emails"
task :send_event_reminders do
  Rake::Task['reminder:wm_remind'].invoke
  Rake::Task['reminder:threedm_remind'].invoke
end