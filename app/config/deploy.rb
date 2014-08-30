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

# other task
after "deploy:share_childs", "deploy:link_environment"
namespace(:deploy) do
  task :link_environment do
    run <<-CMD
      cd #{File.join(release_path, %w|app|)} && ln -nfs environment_staging.php environment.php
    CMD
  end
end
