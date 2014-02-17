require './config/application'
user_provider = UserProvider::Application.initialize!
run user_provider
