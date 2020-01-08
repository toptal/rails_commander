# frozen_string_literal: true

require 'shellwords'
require 'faraday'

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
        !Process.waitpid(pid, Process::WNOHANG)
      rescue Errno::ECHILD
        false
      end
    end

    def ready?
      Faraday.get("http://localhost:#{config.port}")
    rescue StandardError
      false
    else
      true
    end

    def wait_until_ready(timeout: 3, retry_interval: 0.2)
      start = Time.now
      while (!ready?)
        return false if (Time.now - start).to_i >= timeout
        sleep(retry_interval)
      end
      true
    end

    def stop
      return unless running?

      Process.kill('TERM', @pid)
      _pid, status = Process.wait2(pid)
      status
    end

    def task(task)
      status = nil
      Dir.chdir(@path) do
        pid = Process.spawn(
          config.env_vars,
          "bundle exec ./bin/rails #{task}",
          unsetenv_others: config.unset_env_vars,
          out: [config.out_path, 'w'],
          err: [config.err_path, 'w']
        )
        _pid, status = Process.wait2(pid)
      end
      status
    end

    def stderr
      ::File.read(config.err_path)
    end

    def stdout
      ::File.read(config.out_path)
    end
  end
end
