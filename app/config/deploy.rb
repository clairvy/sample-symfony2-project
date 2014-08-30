# to
set :application, "sample-symfony2-project"
set :keep_releases, 3

# from
set :repository, "https://github.com/clairvy/#{application}.git"
set :scm, :git
set :branch, 'book-test'

# misc setting
set :use_sudo, false # generated file owned user, not root
set :use_composer, true # to run composer install/update
set :user, 'kitchen' # to ssh and make permission
set :ssh_options, :keys => "/home/kitchen/.ssh/app1/id_rsa"
logger.level = Logger::MAX_LEVEL
# set :copy_vendors, true # copy before composer install

# set permissions
set :use_set_permissions, true # to set permission
set :webserver_user, "apache"
set :permission_method, :chmod_alt # use chmod -R a+w to writable dirs

# multi stage
set :stages, %w(prod staging)
set :default_stage, "staging"
set :stage_dir, "app/config/deploy"
require 'capistrano/ext/multistage'

# other task
after "deploy:share_childs", "deploy:link_environment"
namespace(:deploy) do
  task :link_environment do
    run <<-CMD
      cd #{File.join(release_path, %w|app|)} && ln -nfs environment_#{stage}.php environment.php
    CMD
  end
end

before "deploy:set_permissions", "deploy:setup_log_setting"
after "deploy:set_permissions", "deploy:teardown_log_setting"
namespace(:deploy) do
  task :setup_log_setting do
    set :use_sudo, true # generated file owned user, not root
  end
  task :teardown_log_setting do
    set :use_sudo, false # generated file owned user, not root
  end
end
