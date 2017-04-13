# config valid only for current version of Capistrano
lock "3.8.0"

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

# Default value for keep_releases is 5
# set :keep_releases, 5


# my additions 

## capistrano config options 

# define the server(s) and roles 
server "192.168.56.11", 
  user: "cjarju",
  roles: [:web, :app, :db], 
  primary: true,
  ssh_options: {
  	port: 22,
    user: "cjarju", 
    # password: "please use keys"
    keys: %w(~/.ssh/id_rsa),
    forward_agent: true,
    auth_methods: %w(publickey)
  }

set :application, 		"fongbloodonors"
set :deploy_to,       	"/home/#{fetch(:user)}/rails/#{fetch(:application)}"
set :repo_url, 			"git@github.com:cjarju/fongbloodonors.git" 				#"https://github.com/cjarju/fongbloodonors.git"
set :linked_files, 		%w{config/database.yml config/secrets.yml}
set :linked_dirs,  		%w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

##  capistrano/bundler config options 

set :bundle_jobs, 1
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_gemfile, -> { release_path.join('Gemfile') }

## capistrano/rails config options 

set :conditionally_migrate, true  		# Skip migration if files in db/migrate were not modified
set :keep_assets, 1						# Defaults to nil (no asset cleanup is performed). 

## capistrano/rbenv config options 

set :rbenv_type, :user 					# or :system, depends on your rbenv setup
set :rbenv_ruby, '2.4.0' 				# specify version as it is in $HOME/.rbenv/versions/ or ~/.rbenv/version
# set :rbenv_ruby, File.read('.ruby-version').strip		# in case you want to set ruby version from the file
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

## capistrano/puma config options 

set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"  # Accept array for multi-bind e.g. %w(tcp://0.0.0.0:9292 unix:///tmp/puma.sock)
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_threads, [5, 16]
set :puma_workers, 2
set :puma_init_active_record, true 								# Change to false when not using ActiveRecord
set :puma_preload_app, true 

## tasks 

  desc 'get hostname'
  task :get_hostname do
  	on roles(:app) do
      execute "hostname"
    end
  end

namespace :puma do

  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do

  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      execute "cd #{current_path}"
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma