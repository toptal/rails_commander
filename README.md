`RailsCommander` is a library that allows the programmatical control over a Rails process. It's a Ruby wrapper for Rails' CLI interface.

Typical use case can be a CI job definition that, among many other steps, requires a spin-up of a Rails app, that is a part of a bigger system under test.

```ruby
config = RailsCommander::Config.new(
  port: 3004                  # default: 3000
  pidfile: '/tmp/server.pid'  # default: ./tmp/pids/server.pid
  out_path: '/tmp/stdout.log' # default: a new tmp file
  err_path: '/tmp/stderr.log' # default: a new tmp file
  env_vars: { 'DEBUG': 1 }    # default: {}
  rails_env: 'cucumber'       # default: development
  unset_env_vars: false       # default: true
)

# config is a Struct, so this will work too:
config.port = 3005

app = RailsCommander::App.new('/path/to/rails/application', config)
app.task('db:reset') # bundle exec rails db:reset
app.start            # bundle exec rails server with given port, env, etc
app.stop             # kill the rails process created with start method
app.stdout           # get the stdout content
app.stderr           # get the stderr content
app.running?         # check if process is running

# or just use default config to run take tasks, without starting the server
RailsCommander::App.new('/path/to/rails/application').task('db:migrate')
```

# Possible caveats

Even though the commands are executed in the another process, in Rails' apps directory, the `bundler` context may be inherited
from the parent process through the environment variables, causing errors about missing gems.

If this happens unset `BUNDLE_GEMFILE` env variable in the config object before starting the app.

```ruby
RailsCommander::Config.new(env_vars: { 'BUNDLE_GEMFILE' => nil })
```

# Testing

Before running `rspec`:

* before first execution: install dependencies required by the embedded test rails app:
```
cd spec/support/bookstore
bundle install
cd -
```

* start the `mysql` instance for the embedded test rails app:
```
docker run --rm --name bookstore-mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=bookstore -e MYSQL_USER=bookstore -e MYSQL_PASSWORD=bookstore -p 3309:3306 mysql/mysql-server:5.6
```

To test your changes:

```
bundle exec rubocop
bundle exec rspec
```
