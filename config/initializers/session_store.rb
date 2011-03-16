# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_agi-backoffice_session',
  :secret      => '41832c63becec3dfa363b9b4b85faf5e9e14204405fe75e0f6dbf00beb962634af90bf63d9f42c134640750946fcb63649da3ff8c2976194064b2ac54489821f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
