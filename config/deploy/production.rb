role :app, %w{deploy@45.55.3.105}
role :web, %w{deploy@45.55.3.105}
role :db, %w{deploy@45.55.3.105}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '45.55.3.105', user: 'deploy', roles: %w{web app}
set :stage, :production