set :deploy_to, '/folder'
set :public_folder, '/home/storyplus-stage/deploy/current/public'

set :env_file, ".env.staging"

server 'server.tld', user: 'user', roles: %w{app}

set :ssh_options, {
  user: 'scheduling',
  keys: %w(~/.ssh/id_rsa),
  # forward_agent: false,
  auth_methods: %w(publickey password)
}
