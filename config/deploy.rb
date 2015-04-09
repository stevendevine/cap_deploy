# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'applicationname'
set :scm, :git
set :repo_url, 'git@bitbucket.org:username/project.git'

# Default value for keep_releases is 5
set :keep_releases, 2

# set :linked_dirs, x=fetch(:linked_dirs)?x:[] + %w{what/ever public/uploads}

namespace :deploy do

  desc "Make Artisan executable"
  task :artisan_executable do
    on roles(:app) do
      within release_path do
        execute :chmod, "u+x artisan"
      end
    end
  end

  desc "Run Laravel migrations (if any)"
  task :migrations do
    on roles(:app) do
      within release_path do
        execute :php, "artisan migrate"
      end
    end
  end

  desc "Sets set of settable settings"
  task :config_mv do
    on roles(:app) do
      within release_path do
        execute :mv, "#{fetch(:env_file)} .env"
      end
    end
  end

  # move config files for poorly designed systems
  after :deploy, "deploy:config_mv"

  after :deploy, "deploy:artisan_executable"
  after :deploy, "deploy:migrations"

  # check/create symlinked folders
  after :deploy, "deploy:check:linked_dirs"
  after :deploy, "deploy:symlink:shared"

end

