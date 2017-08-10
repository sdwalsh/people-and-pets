require_relative '../spec_helper'

feature 'Visitor visits homepage' do
  scenario "vists homepage" do
    visit '/'
    expect(page).to have_content('People')
    expect(page).to have_css 'table'
  end

  scenario "uploads comma file" do
    visit '/'
    attach_file('file', '../test_files/comma.txt')
  end

  scenario "uploads pipe file" do
    visit '/'
    attach_file('file', '../test_files/pipe.txt')
  end

  scenario "uploads space file" do
    visit '/'
    attach_file('file', '../test_files/space.txt')
  end

end