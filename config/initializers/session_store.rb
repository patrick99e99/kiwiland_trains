# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kiwi_trains_session',
  :secret      => 'febf65874af3be29d77153e18bacd859cb04a319552f8414cb965d671d92ece122b5dc5d36c2597f140270f99d9738b2f1ad4a8250ce4bb1486bc169dcff5952'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
