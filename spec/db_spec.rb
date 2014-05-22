require 'spec_helper'

describe 'GPTP::DB' do
  let(:db) {GPTP.db}
  let(:volunteer1) {db.create_volunteer(name: "Susie", password: "123abc", age: 21)}

  before(:each) do
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("organizations")
  end

  it "exists" do
    expect(DB).to be_a(Class)
  end

  it "returns a db" do
    expect(db).to be_a(DB)
  end

  describe 'volunteers' do
    # create_volunteer
    describe 'create_volunteer'
      it "creates a volunteer with a unique name, pw, and age by adding a record and returning a volunteer object" do
        expect(volunteer1.name).to eq("Susie")
        expect(volunteer1.password).to eq("123abc")
        expect(volunteer1.age).to eq(21)
        expect(volunteer1.id).to be_a(Fixnum)
      end

    # get_volunteer
    it "returns a volunteer object" do
      volunteer = db.get_volunteer(volunteer1.name)
      expect(volunteer).to be_a(GPTP::Volunteer)
      expect(volunteer.name).to eq("Susie")
      expect(volunteer.password).to eq("123abc")
      expect(volunteer1.age).to eq(21)
      expect(volunteer1.id).to be_a(Fixnum)
    end

    # update_volunteer
    it "updates a volunteer's information" do
    end

    # remove_volunteer
    it "deletes a volunteer" do
    end

  end
end
