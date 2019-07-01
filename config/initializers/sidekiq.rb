require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  [username, password] == ["sidekiqadmin", "Admin123"]
end