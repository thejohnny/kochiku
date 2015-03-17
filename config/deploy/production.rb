set :ssh_options, { keys: ['/Users/john/Projects/FrontDesk/kochiku/.vagrant/machines/default/parallels/private_key'] }

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Server that is running the Kochiku Rails app
#server 'kochiku.example.com', user: 'kochiku', roles: %w{web app db worker}
server '10.211.55.66', user: 'vagrant', roles: %w{web app db worker}
