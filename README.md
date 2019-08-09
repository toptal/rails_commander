# WORK IN PROGRESS !!

`RailsCommander` is a library that allows the programatical control over Rails process. It's a Ruby wrapper for Rails' CLI interface.

Typical use case can be a CI job definition that, among many other steps, requires a spin-up of a Rails app, that is a part of a bigger system under test.

```ruby
app = RailsCommander.new('/path/to/rails_app')
app.start # wrapper for bundle exec rails s
# run a test scenario that involves rails app running on default port
app.reset_db # wrapper for a rake task setting the DB in the desider state
# run more scenarios
app.stop # kill the process spawned by start method invocation
```
