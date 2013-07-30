Rails.application.config.middleware.use OmniAuth::Builder do
  linkedin = Rails.application.config.linkedin
  provider :linkedin_oauth2, linkedin.api_key, linkedin.api_secret, scope: 'r_fullprofile r_emailaddress r_network w_messages'
end