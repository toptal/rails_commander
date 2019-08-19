# frozen_string_literal: true

require 'faraday'

require_relative '../../lib/rails_commander/app'
require_relative '../support/bookstore_client'

RSpec.describe RailsCommander::App do
  let(:app) { RailsCommander::App.new("#{__dir__}/../support/bookstore") }
  let(:client) { BookstoreClient.new('http://localhost:3000') }

  describe 'start and stop the rails process' do
    specify do
      expect do
        app.start
        app.stop
      end.not_to raise_error
    end
  end

  describe 'reset the db' do
    before(:example) { app.start }
    after(:example) { app.stop }

    specify do
      app.db_reset
      expect(client.data.count).to eq(2)
      client.delete_book(1)
      expect(client.data.count).to eq(1)
      app.db_reset
      expect(client.data.count).to eq(2)
    end
  end
end
