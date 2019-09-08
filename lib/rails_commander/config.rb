# frozen_string_literal: true

require 'shellwords'
require 'securerandom'

module RailsCommander
  Config = Struct.new(
    :port,
    :pidfile,
    :out_path,
    :err_path,
    :env_vars,
    :rails_env,
    :unset_env_vars,
    :cmd_start,
    keyword_init: true
  ) do
    def initialize(*) # rubocop:disable Metrics/AbcSize
      super
      log_prefix = SecureRandom.hex(5)
      self.pidfile ||= './tmp/pids/server.pid'
      self.out_path ||= "/tmp/rails_commander_#{log_prefix}_out.log"
      self.err_path ||= "/tmp/rails_commander_#{log_prefix}_err.log"
      self.rails_env ||= 'development'
      self.port ||= 3000
      self.unset_env_vars ||= true
      self.env_vars ||= {}
      self.cmd_start ||= 'bundle exec ./bin/rails s'\
                        " --port=#{::Shellwords.escape(self.port)}"\
                        " --pid=#{::Shellwords.escape(self.pidfile)}"\
                        " --environment=#{::Shellwords.escape(self.rails_env)}"
    end
  end
end
