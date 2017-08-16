require 'capybara/rspec'
require 'selenium-webdriver'
require_relative '../people_and_pets'

Capybara.server = :puma
Capybara.javascript_driver = :selenium
Capybara.app = PeopleAndPets