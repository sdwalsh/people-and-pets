require 'capybara/rspec'
require 'rspec/retry'
require 'selenium-webdriver'
require_relative '../people_and_pets'

Capybara.app = PeopleAndPets
Capybara.server = :puma
Capybara.javascript_driver = :selenium
Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  # show retry status in spec process
  config.verbose_retry = true
  # Try twice (retry once)
  config.default_retry_count = 2
  # Only retry when Selenium raises Net::ReadTimeout
  config.exceptions_to_retry = [Net::ReadTimeout]
end