# to
set :application, "sample-symfony2-project"
set :deploy_to, "/var/www/staging"
role :app, "app1"
set :keep_releases, 3

# from
set :repository, "https://github.com/clairvy/#{application}.git"
set :scm, :git

# setting
set :use_sudo, false
set :use_composer, true
set :ssh_options, :keys => "/home/kitchen/.ssh/app1/id_rsa"
logger.level = Logger::MAX_LEVEL
