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
      return if running?

      Dir.chdir(@path) do
        @pid = Process.spawn(
          config.env_vars,
          config.cmd_start,
          unsetenv_others: config.unset_env_vars,
          out: [config.out_path, 'w'],
          err: [config.err_path, 'w']
        )
      end
    end

    def running?
      return false unless pid

      begin
        Process.getpgid(pid)
        true
      rescue Errno::ESRCH
        false
      end
    end

    def stop
      return unless running?

      Process.kill('TERM', @pid)
    end

    def task(task)
      Dir.chdir(@path) do
        pid = Process.spawn(
          config.env_vars,
          "bundle exec ./bin/rails #{task}",
          unsetenv_others: config.unset_env_vars,
          out: [config.out_path, 'w'],
          err: [config.err_path, 'w']
        )
        Process.wait(pid)
      end
    end

    def db_reset
      task('db:reset')
    end
  end
end
