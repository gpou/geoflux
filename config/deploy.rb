set :application, "geoflux"
set :repository,  "git@github.com:gpou/#{application}.git"

require 'capistrano/ext/multistage'
require 'bundler/setup'
require 'production_chain/capistrano'

set :stages, %w(recipe production)

set :scm, "git"
set :repository_cache, "git_cache"
set :copy_exclude, [".DS_Store", ".git", "tmp/import"]
ssh_options[:forward_agent] = true

before "deploy:assets:symlink", "db:symlink"

after "deploy:update_code", "db:symlink"
after "deploy:setup", "db:mkdir"

namespace :db do
  # make a symbolik link on the server of database.yml in shared/config directory to the release/config directory.
  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{current_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/robots.txt #{current_release}/public/robots.txt"
    run "ln -nfs #{shared_path}/system #{current_release}/public/system"
    run "ln -nfs #{shared_path}/private #{current_release}/private"
  end

  desc "Create necessary directories"
  task :mkdir do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/private"
    run "touch #{shared_path}/config/database.yml"
  end
end

namespace :privates do
  desc "Make a zip of private on the remote production box and restore on the local dev box"
  task :dump_and_restore, :roles => :db, :only => {:primary => true} do
    assets_backup_path = "#{current_path}/private.tar.gz"
    run "cd #{current_path}/ && tar czfh #{assets_backup_path} private/"
    get "#{assets_backup_path}", "private.tar.gz"
    run "cd #{current_path}/ && rm #{assets_backup_path}"
    `rm -rf private/*`
    `tar xvzf private.tar.gz`
  end
end

namespace :deploy do
  desc <<-DESC
  Restart the application altering tmp/restart.txt for mod_rails.
  DESC
  task :restart, :roles => :app do
    run "touch  #{current_release}/tmp/restart.txt"
  end
end

namespace :delayed_job do
  desc "start delayed job"
  task :start, :roles => :app, :only => { :primary => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} script/delayed_job start"
  end

  desc "stop delayed job"
  task :stop, :roles => :app, :only => { :primary => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} script/delayed_job stop"
  end

  desc "restart delayed job"
  task :restart, :roles => :app, :only => { :primary => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} script/delayed_job restart"
  end

  desc "clear all jobs"
  task :clear, :roles => :app, :onley => { :primary => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rake jobs:clear"
  end
end

namespace :mailcatcher do
  desc "start mailcatcher"
  task :start, :roles => :app, :only => { :primary => true } do
    run "cd #{current_path} && mailcatcher --http-ip=0.0.0.0"
  end
end