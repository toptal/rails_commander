# frozen_string_literal: true

module RailsCommander
  Config = Struct.new(:log_path, :cmd_start, :port, keyword_init: true) do
    def initialize(*)
      super
      self.port ||= 3000
      self.log_path ||= '/tmp/rails_commander.log'
      self.cmd_start ||= "bundle exec ./bin/rails s -p #{self.port}"
    end
  end
end
