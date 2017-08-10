require 'capybara/rspec'
require_relative '../people_and_pets'

Capybara.app = PeopleAndPets
Capybara.server = :puma