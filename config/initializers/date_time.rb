ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :default_date => '%m/%d/%Y',
  :default_time => lambda { |time| time.strftime('%I:%M %p').gsub(/^0/,'').downcase }
)