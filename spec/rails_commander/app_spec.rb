# frozen_string_literal: true

require_relative '../../lib/rails_commander/app'

RSpec.describe RailsCommander::App do
  describe 'start and stop the process' do
    let(:app) { RailsCommander::App.new('/tmp', config) }
    let(:config) { RailsCommander::Config.new(cmd_start: 'top') }

    specify do
      expect do
        app.start
        app.stop
      end.not_to raise_error
    end
  end
end
