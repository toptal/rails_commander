# frozen_string_literal: true

module RailsCommander
  Config = Struct.new(:log_path, :cmd_start, keyword_init: true) do
    def initialize(*)
      super
      self.log_path ||= '/tmp/rails_commander.log'
      self.cmd_start ||= 'bundle exec ./bin/rails s'
    end
  end
end
