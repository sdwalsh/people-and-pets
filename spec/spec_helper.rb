require 'capybara/rspec'
require 'selenium-webdriver'
require_relative '../people_and_pets'

Capybara.app = PeopleAndPets
Capybara.server = :puma
Capybara.javascript_driver = :selenium
Capybara.default_wait_time = 10