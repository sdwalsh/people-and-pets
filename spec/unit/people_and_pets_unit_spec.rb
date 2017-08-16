require 'spec_helper'
 
describe PeopleAndPets do
  before do
    @app = PeopleAndPets.new!

    # Construct correct response to comma file
    @response = []
    hash = {:last=>"Radican", :first=>"Shalonda", :m=>"None", :pet=>"Cat", :birthday=>"4/14/1945", :color=>"Turquoise"}
    @response.push(hash)
    hash = {:last=>"Brinckerhoff", :first=>"Jennifer", :m=>"None", :pet=>"Dog", :birthday=>"9/20/1980", :color=>"Yellow"}
    @response.push(hash)
    hash = {:last=>"Votraw", :first=>"Moses", :m=>"None", :pet=>"None", :birthday=>"11/13/1964", :color=>"Blue"}
    @response.push(hash)

    # Absolute path to files
    @comma = File.absolute_path("spec/test_files/comma.txt")
    @both = File.absolute_path("spec/test_files/both.png")
  end

  # Normalize
  it "noramlize returns nil if no delimeter" do
    expect(@app.normalize(@comma, '')).to eq(nil)
  end

  it "noramlize returns expected array of hashes" do
    expect(@app.normalize(@comma, ',')).to eq(@response)
  end

  it "noramlize returns nil if incorrect delimeter" do
    expect(@app.normalize(@comma, '/')).to eq(nil)
  end

  # Sniffer
  it "sniffer correctly determines the delimeter" do
    expect(@app.sniffer(@comma)).to eq(',')
  end

  it "sniffer returns nil if file has no delimeter" do
    expect(@app.sniffer(@both)).to eq(nil)
  end
end