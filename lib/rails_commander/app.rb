# frozen_string_literal: true

require_relative './config'

module RailsCommander
  class App
    attr_reader :config
    attr_reader :path
    attr_reader :pid

    def initialize(path, config = nil)
      @path = path
      @config = config || RailsCommander::Config.new
    end

    def start
      Dir.chdir(@path) do
        @pid = Process.spawn(
          config.cmd_start,
          unsetenv_others: config.unset_env_vars,
          %i[out err] => [config.log_path, 'w']
        )
      end
    end

    def stop
      Process.kill('TERM', @pid)
    end

    def db_reset
      Dir.chdir(@path) do
        pid = Process.spawn(
          'bundle exec ./bin/rails db:reset',
          unsetenv_others: config.unset_env_vars,
          %i[out err] => [config.log_path, 'w']
        )
        Process.wait(pid)
      end
    end
  end
end
