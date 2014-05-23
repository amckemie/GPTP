require 'spec_helper.rb'

describe GPTP::GetPennies do
  before(:each) do
    GPTP.db.clear_table("pennies")
    GPTP.db.clear_table("volunteers")
    GPTP.db.clear_table("organizations")
  end

  it 'exists' do
    expect(GPTP::GetPennies).to be_a(Class)
  end

  describe '#run' do
    it 'should return an error if the user does not have any pennies' do

    end

    it 'should return an error with upcoming pennies if the user does not have any past pennies' do
    end

    it 'should return an error with past pennies if the user does not have any upcoming pennies' do
    end

    it 'should return true with array of the users past and present pennies' do
    end
  end

end
