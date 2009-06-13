# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_aolscapp_session',
  :secret      => 'cb76bf2d11d1a20ca68438bd4e9a9d81c6c2432429a112f169c14ad27cca928b3029a9e0692f9e03b46ad9e3d4d498e38c2b365cd44bca2014e8c53dd5460f57'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
