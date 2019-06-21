set :branch, "development"
set :stage, :test
set :rails_env, "test"
set :migration_role, "db"
#server "35.200.14.7", user: "kusanagi", roles: %w{app db web}
server "testing.material-group.com", user: "kusanagi", roles: %w{app db web}
set :ssh_options, port: 34581, forward_agent: true
after "deploy", "refresh_sitemaps"
task :refresh_sitemaps do
  on roles(:web) do
    execute "cd /home/kusanagi/sleepdays/current && RAILS_ENV=test rails sitemap:create"
  end
end
