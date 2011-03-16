Factory.define :user do |u|
  u.email { Factory.next(:email) }
  u.first_name 'AGI'
  u.last_name 'User'
  u.password 'password'
  u.password_confirmation 'password'
  u.type 'User'
end

Factory.define :admin, :parent => :user do |u|
  u.first_name 'AGI'
  u.last_name 'Admin'
end

Factory.define :affiliate, :parent => :user do |u|
  u.first_name 'AGI'
  u.last_name 'Affiliate'
  u.type "Affiliate"
end