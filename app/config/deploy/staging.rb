set :symfony_env_prod, 'staging' # to pass composer and others
set :deploy_to, "/var/www/staging"

server "app1", :app, :primary => true # primary setting to run migrate
