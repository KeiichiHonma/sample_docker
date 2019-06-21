set :branch, 'feature-2'
set :stage, :test
set :rails_env, 'test'
set :migration_role, 'db'
server 'feature-2.material-group.com', user: 'kusanagi', roles: %w{app web db}
#server '35.194.112.163', user: 'kusanagi', roles: %w{app db web}
set :ssh_options, {
    port: 34581,
    # forward_agent: true,
}
