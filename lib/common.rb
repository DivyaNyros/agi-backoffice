require 'curb'
require "cgi"

def submit_to_icontact(attendee, prefix, list_number = nil)
  easy = Curl::Easy.new
  easy.encoding = "UTF-8"
  email = easy.escape(attendee.email)
  first_name = easy.escape(attendee.first_name)
  last_name = easy.escape(attendee.last_name)
  phone = easy.escape(!attendee.phone_numbers.nil? ? attendee.phone_numbers.first : "")
  street = easy.escape("")
  city = easy.escape("")
  state = easy.escape("")
  zip = easy.escape("")

  unless list_number.nil?
    postfields = "fields_email=#{email}&fields_fname=#{first_name}&fields_lname=#{last_name}&fields_phone=#{phone}&fields_address1=#{street}&fields_city=#{city}&fields_state=#{state}&fields_zip=#{zip}&listid%3A#{list_number}=on&#{prefix}"
  else
    postfields = "fields_email=#{email}&fields_fname=#{first_name}&fields_lname=#{last_name}&fields_phone=#{phone}&fields_address1=#{street}&fields_city=#{city}&fields_state=#{state}&fields_zip=#{zip}&#{prefix}"
  end

  url = "http://app.icontact.com/icp/signup.php?" + postfields

  c = Curl::Easy.http_get(url) do |curl|
    curl.headers["User-Agent"] = "Mozilla/5.0 (Windows; U; Windows NT 6.1; es-ES; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3"
    curl.headers["Referrer"] = "app.icontact.com"
    curl.headers["Content-Type"] = "text/html; charset=utf-8"
    curl.encoding = "UTF-8"
    curl.follow_location = true
    curl.enable_cookies = true
  end
  
  if c.body_str.index("Thank you for joining") > 0
    puts "Succeeded submit #{email} to #{list_number}"
  else
    puts "Failed to submit #{email} to #{list_number}"
  end
end

def submit_attendee_to_icontact(attendee, event)
  address = event.addresses.first.street rescue ""
  address = CGI.escape(event.location + " " + address) rescue ""
  city = CGI.escape(event.addresses.first.city) rescue ""
  state = CGI.escape(event.addresses.first.state) rescue ""
  day_of_week = event.start_date.strftime("%A") rescue ""
  start_time = CGI.escape(event.start_time.to_s(:default_time)) rescue ""
  end_time = CGI.escape(event.end_time.to_s(:default_time)) rescue ""
  zipcode = CGI.escape(event.addresses.first.zipcode) rescue ""
  start_date = CGI.escape(event.start_date.strftime("%B %d, %Y"))
  end_date = CGI.escape(event.end_date.strftime("%B %d, %Y"))
  submit_to_icontact(attendee, "fields_event_date=#{start_date}&fields_event_address=#{address}&fields_event_city=#{city}&fields_event_state=#{state}&fields_event_day_of_week=#{day_of_week}&fields_event_end_date=#{end_date}&fields_event_start_time=#{start_time}&fields_event_end_time=#{end_time}&fields_event_zip_code=#{zipcode}&listid=24653&specialid%3A24653=Y2KR&clientid=714906&formid=1910&reallistid=1&doubleopt=0")
end

# TODO: I think we can put these in application_helper instead of here in lib/common.rb
def get_event_eastern_time(event)
  str = "#{event.start_date.strftime("%m/%d/%Y")}" rescue ""
  str += " #{event.start_time.strftime("%H:%M")}" unless event.start_time.nil?
  str += " EST"
  Time.parse(str)
end

def get_eastern_time_now
  str = Time.now.strftime("%m/%d/%Y %H:%M EST")
  Time.parse(str)
end

def normalize_email(email)
  email.to_s.strip.downcase
end