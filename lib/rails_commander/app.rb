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
        @pid = Process.spawn(config.cmd_start, %i[out err] => [config.log_path, 'w'])
      end
    end

    def stop
      Process.kill('TERM', @pid)
    end
  end
end
