Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :developer
    provider :twitter, 'pex9fYUf0WwsK3G8FzIMw', '51J2N0N9Gbg9VLg7oGqwyGFZBmJigWkq02Tba2EA'
    # provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  end
end