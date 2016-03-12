lock '3.4.0'

set :application, 'todos'
set :repo_url, 'git@github.com:ramky/rails-react-flux-todo-app.git'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp  }
puts "Deploying #{fetch(:branch)}"
set :deploy_to, '/apps/todos'
set :linked_dirs, %w(tmp/pids)
set :rbenv_type, :system
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_map_bins, %w[rake gem bundle ruby rails]
set :linked_files, %w[.rbenv-vars]

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
  after :updated, :compile_assets

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end

