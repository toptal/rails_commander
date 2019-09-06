# frozen_string_literal: true

module RailsCommander
  Config = Struct.new(:log_path, :cmd_start, :port, :pidfile, :env, :unset_env_vars, keyword_init: true) do
    def initialize(*)
      super
      self.pidfile ||= './tmp/pids/server.pid'
      self.log_path ||= '/tmp/rails_commander.log'
      self.env ||= 'development'
      self.port ||= 3000
      self.unset_env_vars ||= true
      self.cmd_start ||= "bundle exec ./bin/rails s --port=#{self.port} --pid=#{self.pidfile} --environment=#{self.env}"
    end
  end
end
