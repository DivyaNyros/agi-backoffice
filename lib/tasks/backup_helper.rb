def get_db_settings
  local_user = YAML::load(IO.read(RAILS_ROOT + '/config/database.yml'))[RAILS_ENV]["username"]
  local_password = YAML::load(IO.read(RAILS_ROOT + '/config/database.yml'))[RAILS_ENV]["password"]
  database_url = ENV['DATABASE_URL'] || "postgres://#{local_user}:#{local_password}@localhost/c4yl_backoffice_development"
  matches = database_url.match(/postgres:\/\/([^:]+):([^@]+)@([^\/]+)\/(.+)/)
  access_key_id = YAML::load(IO.read(RAILS_ROOT + '/config/s3.yml'))['access_key_id']
  secret_access_key = YAML::load(IO.read(RAILS_ROOT + '/config/s3.yml'))['secret_access_key']
  obsoleted_days = YAML::load(IO.read(RAILS_ROOT + '/config/s3.yml'))['obsoleted_days']
  {:username => matches[1], 
   :password => matches[2],
   :host => matches[3],
   :db_name => matches[4],
   :access_key_id => access_key_id,
   :secret_access_key => secret_access_key,
   :obsoleted_days => obsoleted_days}
end

def pg_dump(filename)
  settings = get_db_settings
  ENV['PGPASSWORD'] = settings[:password]
  `pg_dump -a -i -h #{settings[:host]} -U #{settings[:username]} -F c #{settings[:db_name]} > "tmp/#{filename}.pgdump"`
  filename
end

def pg_restore(filename)
  settings = get_db_settings
  ENV['PGPASSWORD'] = settings[:password]
  `pg_restore -c -O -x -h #{settings[:host]} -U #{settings[:username]} -d #{settings[:db_name]} "tmp/#{filename}"`
  # -c : clean
  # -O : no owner
  # -x : no privileges
end
 
def connect_s3!
  settings = get_db_settings
  AWS::S3::Base.establish_connection!(
    #:access_key_id     => "1GZERYSFN2VPTT3J8582",
    :access_key_id     => settings[:access_key_id],
    #:secret_access_key => "+gMZ8N7S3cB4ea9Xog1ckU7++mPQ3Axj6+RniKeY"
    :secret_access_key => settings[:secret_access_key]
  )
end

def s3_latest(bucket_name, prefix)
  connect_s3!
  objects = AWS::S3::Bucket.objects(bucket_name, :prefix => prefix)
  objects.last.path.split('/').last
end

def s3_download(bucket_name, file_name)
  connect_s3!
  open("tmp/#{file_name}", 'w') do |file|
    AWS::S3::S3Object.stream(file_name, bucket_name) do |chunk|
      file.write chunk
    end
  end

  file_name
end

def s3_upload(bucket_name, file_location)
  file_name = file_location.split('/').last
  connect_s3!
  begin
    bucket = AWS::S3::Bucket.find bucket_name
  rescue AWS::S3::NoSuchBucket
    AWS::S3::Bucket.create bucket_name
    bucket = AWS::S3::Bucket.find bucket_name
  end
  AWS::S3::S3Object.store file_name, File.read(file_location), bucket.name
end

def s3_delete_obsolete_backups(bucket_name, prefix)
  settings = get_db_settings
  connect_s3!
  bucket = AWS::S3::Bucket.find(bucket_name)
  objects = bucket.objects
  deleted_objects = []

  objects.each do |object|
    object_name = object.path.split("/").last

    if object_name.include?(prefix) && Time.parse(Date.today.to_s) - object.last_modified > settings[:obsoleted_days].to_i*24*60*60
      deleted_objects << object_name
      object.delete
    end
  end

  return deleted_objects
end
