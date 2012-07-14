require "./lib/capistrano_ts"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "news.tymoshuk.net"
set :repository, "https://github.com/rtym/DemoGame.git"
set :scm, :git
set :deploy_via, :remote_cache
set :keep_releases, 10
set :branch, "master"
set :user, "deployer"
set :password, "deployerX292_go"
set :use_sudo, true
set :deploy_to, "/srv/http/#{application}/"

task :symlink_sphinx_indexes, :roles => [:app] do
  run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
end

task :prod do
  web_server = "#{application}"
  role :web, web_server # Your HTTP server, Apache/etc
  role :app, web_server # This may be the same as your `Web` server
  role :db, web_server, :primary => true # This is where Rails migrations will run
end

namespace :deploy do
  desc "Tell Passenger to restart the app."
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :bundle_update, :roles => :app do
    run "cd #{release_path} && bundle update"
  end

  task :bundle_install, :roles => :app do
    run "cd #{release_path} && bundle install"
  end
end

after 'deploy:update_code', 'deploy:bundle_install'

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end