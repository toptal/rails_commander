# WORK IN PROGRESS !!

`RailsCommander` is a library that allows the programmatical control over Rails process. It's a Ruby wrapper for Rails' CLI interface.

Typical use case can be a CI job definition that, among many other steps, requires a spin-up of a Rails app, that is a part of a bigger system under test.

```ruby
app = RailsCommander::App.new('/path/to/rails/application')
app.db_reset  # bundle exec rails db:reset
app.start     # bundle exec rails s
app.stop      # kill the rails process created with start method
```

# Testing

Before running `rspec` start the `mysql` instance for the embedded test rails app:

```
docker run --rm --name bookstore-mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=bookstore -e MYSQL_USER=bookstore -e MYSQL_PASSWORD=bookstore -p 3309:3306 mysql/mysql-server:5.6
```

# TODO List

 * [ ] Configure logging paths for `:out` and `:err`
 * [ ] Execute any rake task
