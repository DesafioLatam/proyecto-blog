# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'superblog'
set :scm, :git
set :repo_url, 'git@github.com:DesafioLatam/proyecto-blog.git'
set :branch, 'master'
set :deploy_via, :copy
set :user, 'deploy'

set :deploy_to, '/home/deploy/apps/superblog'
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

namespace :tasks do
  desc 'Rake assets:clean'
  task :clean do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, 'assets:clean'
          execute :touch, release_path.join('tmp/restart.txt')
        end
      end
    end
  end
end
