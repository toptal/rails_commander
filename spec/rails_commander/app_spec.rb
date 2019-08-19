# frozen_string_literal: true

require_relative '../../lib/rails_commander/app'

RSpec.describe RailsCommander::App do
  describe 'start and stop the rails process' do
    let(:app) { RailsCommander::App.new("#{__dir__}/../support/bookstore") }

    specify do
      expect do
        app.start
        app.stop
      end.not_to raise_error
    end
  end
end
