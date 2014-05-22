require 'spec_helper'
require 'fileutils'
require 'time'

describe 'GPTP::DB' do
  let(:db) do
    if File.exists?("test.db")
      FileUtils.rm("test.db")
    end

    GPTP::DB.new("test.db")
  end

  let(:volunteer1) {db.create_volunteer(name: "Susie", password: "123abc", age: 21, email: "susie@gmail.com")}
  let(:organization1) {db.create_organization(name: "Doing Good", password: "dgdg", description: "doing good stuff", phone_num: "512-123-4567", address: "123 road drive", email: "org@gmail.com")}

  it "exists" do
    expect(DB).to be_a(Class)
  end

  it "returns a db" do
    expect(db).to be_a(DB)
  end

  describe 'volunteers' do
    # create_volunteer
    it "creates a volunteer with a unique name, pw, and age by adding a record and returning a volunteer object" do
      expect(volunteer1.name).to eq("Susie")
      expect(volunteer1.password).to eq("123abc")
      expect(volunteer1.age).to eq(21)
      expect(volunteer1.email).to eq("susie@gmail.com")
      expect(volunteer1.id).to be_a(Fixnum)
    end
    # get_volunteer
    it "returns a volunteer object" do
      volunteer = db.get_volunteer(volunteer1.email)
      expect(volunteer).to be_a(GPTP::Volunteer)
      expect(volunteer.name).to eq("Susie")
      expect(volunteer.password).to eq("123abc")
      expect(volunteer.age).to eq(21)
      expect(volunteer.email).to eq("susie@gmail.com")
      expect(volunteer.id).to be_a(Fixnum)
    end

    # update_volunteer
    it "updates a volunteer's information" do
      volunteer = db.update_volunteer(volunteer1.email, age: 24)
      expect(volunteer.name).to eq(volunteer1.name)
      expect(volunteer.age).to eq(24)
      expect(volunteer.email).to eq("susie@gmail.com")
      expect(db.get_volunteer(volunteer1.email).age).to eq(24)
    end

    # remove_volunteer
    it "deletes a volunteer" do
      expect(db.remove_volunteer(volunteer1.name)).to eq([])
    end

    it "lists all volunteers" do
      volunteer1
      db.create_volunteer(name: "Ashley", password: "456", age: 25, email: "ashley@gmail.com")
      volunteers = db.list_volunteers
      expect(volunteers.size).to eq(2)
      expect(volunteers[0].name).to eq("Susie")
      expect(volunteers[1].name).to eq("Ashley")
    end
  end

  describe 'organizations' do
    # create_organization
    it "creates an organization with a unique id, adds it to the database and returns an organization object" do
      expect(organization1.name).to eq("Doing Good")
      expect(organization1.password).to eq("dgdg")
      expect(organization1.description).to eq("doing good stuff")
      expect(organization1.phone_num).to eq("512-123-4567")
      expect(organization1.address).to eq("123 road drive")
      expect(organization1.id).to be_a(Fixnum)
    end

    it "returns a organization object" do
      organization = db.get_organization(organization1.email)
      expect(organization).to be_a(GPTP::Organization)
      expect(organization1.name).to eq("Doing Good")
      expect(organization1.password).to eq("dgdg")
      expect(organization1.description).to eq("doing good stuff")
      expect(organization1.phone_num).to eq("512-123-4567")
      expect(organization1.address).to eq("123 road drive")
      expect(organization1.id).to be_a(Fixnum)
    end
    # update_organization
    it "updates a organization's information" do
      organization = db.update_organization(organization1.email, name: "Good Company", address: "123 good road")
      expect(organization.phone_num).to eq(organization1.phone_num)
      expect(organization.name).to eq("Good Company")
      expect(organization.password).to eq("dgdg")
      expect(organization.description).to eq("doing good stuff")
      expect(organization.address).to eq("123 good road")
      expect(db.get_organization(organization1.email).name).to eq("Good Company")
    end

    # remove_organization
    it "deletes a organization" do
      expect(db.remove_organization(organization1.email)).to eq([])
    end

    it "lists all organizations" do
      organization1
      db.create_organization(name: "Company 2", password: "asdfgh", description: "New Company", phone_num: "000-000-0000", address: "123 drive drive", email: "new_org@gmail.com")
      db.create_organization(name: "Company 3", password: "12345", description: "Another Company", phone_num: "111-111-1111", address: "123 road", email: "another_org@gmail.com")
      organizations = db.list_organizations
      expect(organizations.size).to eq(3)
      expect(organizations[0].name).to eq("Doing Good")
      expect(organizations[1].name).to eq("Company 2")
      expect(organizations[2].name).to eq("Company 3")
    end
  end

  describe 'pennies' do

    it 'creates a penny' do
      t = Time.now
      today = "#{t.year} #{t.month} #{t.day}"
      penny = db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, status: 0, vol_id: 1, location: "dog park")
      p penny
      expect(penny).to be_a(Penny)
    end

    it 'updates penny' do
      t = Time.now
      today = "#{t.year} #{t.month} #{t.day}"
      penny = db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, status: 0, vol_id: 1, location: "dog park")
      # p penny
      penny = db.update_penny(1, {status: 1})
      # p penny
      expect(penny.status).to eq 1
    end

    it 'gets penny' do
      t = Time.now
      today = "#{t.year} #{t.month} #{t.day}"
      penny = db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, status: 0, location: "dog park")
      penny2 = db.get_penny(1)
      p penny2
      expect(penny2).to be_a(Penny)
    end

    it "lists all pennies" do
      t = Time.now
      today = "#{t.year} #{t.month} #{t.day}"
      penny = db.create_penny(name: "test", description: "do good", org_id: 1, time_requirement: 4, time: 'noon', date: today, status: 0, vol_id: 1, location: "dog park")
      penn2 = db.create_penny(name: "test2", description: "have fun", org_id: 1, time_requirement: 3, time: 'noon', date: today, status: 0, vol_id: 1, location: "school")
      pennies = db.list_pennies
      expect(pennies.size).to eq(2)
      expect(pennies[0].name).to eq("test")
      expect(pennies[1].name).to eq("test2")
    end
  end
end
