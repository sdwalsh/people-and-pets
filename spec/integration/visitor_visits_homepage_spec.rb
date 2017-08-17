require 'spec_helper'

describe "uploads file", :type => :feature do
  it "updates table and count", js: true do
    visit '/'
    find('#browse').click
    
    path = File.absolute_path("spec/test_files/comma.txt")
    find('#fileInput', visible: false).set(path)

    expect(page).to have_selector('td')
    expect(page).to have_content('3 People')
  end

  it "updates table and count for more than one file", js: true do
    visit '/'
    # File 1
    find('#browse').click
    path = File.absolute_path("spec/test_files/comma.txt")
    find('#fileInput', visible: false).set(path)

    # File 2
    find('#browse').click
    path = File.absolute_path("spec/test_files/pipe.txt")
    find('#fileInput', visible: false).set(path)

    # File 3
    find('#browse').click
    path = File.absolute_path("spec/test_files/space.txt")
    find('#fileInput', visible: false).set(path)

    expect(page).to have_selector('td')
    expect(page).to have_content('9 People')
    expect(page).to have_content('Radican Shalonda None Cat 4/14/1945 Turquoise')
  end

  it "does not update table if file is not valid", js: true do
    visit '/'
    find('#browse').click

    path = File.absolute_path('spec/test_files/both.png')
    find('#fileInput', visible: false).set(path)

    expect(page).not_to have_selector('td')
  end

  it "updates sort order when selected", js: true do
    visit '/'
    # File 1
    find('#browse').click
    path = File.absolute_path("spec/test_files/comma.txt")
    find('#fileInput', visible: false).set(path)

    # File 2
    find('#browse').click
    path = File.absolute_path("spec/test_files/pipe.txt")
    find('#fileInput', visible: false).set(path)

    # File 3
    find('#browse').click
    path = File.absolute_path("spec/test_files/space.txt")
    find('#fileInput', visible: false).set(path)

    expect(page).to have_selector('td')
    expect(page).to have_content('9 People')
    expect(page).to have_content('Radican Shalonda None Cat 4/14/1945 Turquoise')

    # Reorder and check first row
    find("th", :text => /\ABirthday\z/).click
    expect(first(:css, 'tbody tr')).to have_content('Doloris Cacioppo M Cat 12/9/1926 Red')
  end
end