set :branch, "master"
set :stage, :production
set :rails_env, "production"
set :migration_role, "db"
server "green.material-group.com", user: "kusanagi", roles: %w{app db web}
#server "35.200.102.177", user: "kusanagi", roles: %w{app db web}
set :ssh_options, port: 34581, forward_agent: true
