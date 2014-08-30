set :symfony_env_prod, 'prod'
set :deploy_to, "/var/www/prod"

server "app1", :app, :primary => true # primary setting to run migrate
