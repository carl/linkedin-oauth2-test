class SessionsController < ApplicationController
  def create
    @auth = request.env['omniauth.auth']
    session[:auth_hash] = @auth.except('extra')
  end

  def new
    auth = session[:auth_hash]
    token = auth['credentials']['token']
    @signup_attributes = linkedin_signup_attributes token
  end

  private

  def linkedin_signup_attributes(token)
    fields = %w(id email-address first-name last-name headline numConnections
              location industry skills picture-urls::(original)
    )

    access_token = OAuth2::AccessToken.new(client, token, {
      :mode => :query,
      :param_name => "oauth2_access_token",
    })

    url = "https://www.linkedin.com/v1/people/~:(#{fields.join(',')})?format=json"
    access_token.get(url).parsed
  end

  def client
    linkedin = Rails.application.config.linkedin
    OAuth2::Client.new(
      linkedin.api_key,
      linkedin.api_secret,
      :authorize_url => "/uas/oauth2/authorization?response_type=code",
      :token_url => "/uas/oauth2/accessToken",
      :site => "https://www.linkedin.com"
    )
  end
end