lock "~> 3.11.0"
set :application, "sleepdays"
set :repo_url, "git@github.com:materialpr/sleepdays"
set :deploy_to, "/home/kusanagi/sleepdays"
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets bundle public/system public/assets public/sitemaps}
#set :linked_files, fetch(:linked_files, []).push(".env", "config/master.key", "public/sitemap.xml.gz")
set :linked_files, fetch(:linked_files, []).push(".env", "config/master.key")
set :keep_releases, 3
set :log_level, :debug
set :whenever_roles, -> { :app }
after "deploy", "passenger"
task :passenger do
  on roles(:web) do
    #execute "sudo /bin/systemctl reload nginx.service"
    execute "sudo /bin/passenger-config restart-app /home/kusanagi/sleepdays/current"

  end
end
