# frozen_string_literal: true

module RailsCommander
  Config = Struct.new(:out_path, :err_path, :cmd_start, :port, :pidfile, :env_vars, :rails_env, :unset_env_vars, keyword_init: true) do
    def initialize(*)
      super
      self.pidfile ||= './tmp/pids/server.pid'
      self.out_path ||= '/tmp/rails_commander_out.log'
      self.err_path ||= '/tmp/rails_commander_err.log'
      self.rails_env ||= 'development'
      self.port ||= 3000
      self.unset_env_vars ||= true
      self.env_vars ||= {}
      self.cmd_start ||= "bundle exec ./bin/rails s --port=#{self.port} --pid=#{self.pidfile} --environment=#{self.rails_env}"
    end
  end
end
