require 'spec_helper.rb'
require 'time'

describe 'GPTP::ListEntities' do
  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("organizations")
  end

  it "exists" do
    expect(GPTP::ListEntities).to be_a(Class)
  end

  let(:organization1) {GPTP.db.create_organization(name: "Doing Good", password: "dgdg", description: "doing good stuff", phone_num: "512-123-4567", address: "123 road drive", email: "org@gmail.com")}
  let(:organization2) {GPTP.db.create_organization(name: "Doing Good2", password: "dgdg2", description: "doing good stuff", phone_num: "512-123-4567", address: "123 road drive", email: "org2@gmail.com")}
  let(:organization3) {GPTP.db.create_organization(name: "Doing Good3", password: "dgdg3", description: "doing good stuff", phone_num: "512-123-4567", address: "123 road drive", email: "org3@gmail.com")}
  let(:volunteer1) {GPTP.db.create_volunteer(name: "Susie", password: "123abc", age: 21, email: "susie@gmail.com")}
  let(:volunteer2) {GPTP.db.create_volunteer(name: "Ashley", password: "123abc", age: 21, email: "ashley@gmail.com")}
  let(:penny1) {GPTP.db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: "#{Time.now.year} #{Time.now.month} #{Time.now.day}", status: 0, vol_id: 1, location: "dog park")}
  let(:penny2) {GPTP.db.create_penny(name: "test2", description: "do good2", org_id: 2, time_requirement: 4, time: 'noon', date: "#{Time.now.year} #{Time.now.month} #{Time.now.day}", status: 0, vol_id: 1, location: "dog park")}

  it "returns an array of objects based on which type is passed in" do
    organization1
    organization2
    organization3
    result = GPTP::ListEntities.new.run(type: "organization")
    expect(result[:success?]).to eq(true)
    expect(result[:result].size).to eq(3)
    expect(result[:result][0]).to be_a(GPTP::Organization)
    volunteer1
    volunteer2
    result2 = GPTP::ListEntities.new.run(type: "volunteer")
    expect(result2[:success?]).to eq(true)
    expect(result2[:result].size).to eq(2)
    expect(result2[:result][0]).to be_a(GPTP::Volunteer)
    penny1
    penny2
    result3 = GPTP::ListEntities.new.run(type: "penny")
    expect(result3[:success?]).to eq(true)
    expect(result3[:result].size).to eq(2)
    expect(result3[:result][1]).to be_a(GPTP::Penny)
  end

  it "returns a success message if there are 1 or more of the inputted type of entity" do
  end

  it "returns a success failure message if there are 0 of the inputted type of entity" do
  end
end
