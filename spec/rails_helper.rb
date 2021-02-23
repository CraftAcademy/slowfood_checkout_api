# frozen_string_literal: true

require 'coveralls'
Coveralls.wear_merged!('rails')

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'spec_helper'
require 'rspec/rails'
require 'webmock/rspec'
WebMock.disable_net_connect!

ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include ResponseJSON
  config.before(:each) do
    fixture = File.open("#{fixture_path}/market_caps_fixture.json").read
    stub_request(:get, 'https://api.nomics.com/v1/market-cap/history?key=aaf997cff4f9e722484a7a24ca78e9d3&start=2021-02-15T13:29:31.070Z')
      .to_return(status: 200, body: fixture, headers: {})
  end
end
