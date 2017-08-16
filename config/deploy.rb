# config valid only for current version of Capistrano
lock "3.9.0"

set :application, 'uniapp2'
set :repo_url, 'https://github.com/youmnam/uniapp2.git' # Edit this to match your repository
set :branch, :master

set :user, 'deploy'
set :deploy_to, '/home/deploy/uniapp2'
set :use_sudo, false
set :scm, :git

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/puma.rb')
 
# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
 
#set :pty, true
#set :linked_files, %w{config/database.yml config/application.yml}
#set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
#set :keep_releases, 5
#set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.4.0' # Edit this if you are using MRI Ruby

#set :puma_rackup, -> { File.join(current_path, 'config.ru') }
#set :puma_state, "#{shared_path}/tmp/pids/puma.state"
#set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
#set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
#set :puma_conf, "#{shared_path}/puma.rb"
#set :puma_access_log, "#{shared_path}/log/puma_error.log"
#set :puma_error_log, "#{shared_path}/log/puma_access.log"
#set :puma_role, :app
#set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
#set :puma_threads, [0, 8]
#set :puma_workers, 0
#set :puma_worker_timeout, nil
#set :puma_init_active_record, true
#set :puma_preload_app, false

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5
# Puma:
set :puma_conf, "#{shared_path}/config/puma.rb"
 
namespace :deploy do
  before 'check:linked_files', 'puma:config'
  before 'check:linked_files', 'puma:nginx_config'
  after 'puma:smart_restart', 'nginx:restart'
end