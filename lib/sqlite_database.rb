require 'sqlite3'

class GPTP::SQLiteDatabase

  def initialize
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'new-test.db'
    )
  end

  # Define models and relationships here (yes, classes within a class)
  class Penny < ActiveRecord::Base
    belongs_to :volunteer
    belongs_to :organization
  end

  class Volunteer < ActiveRecord::Base
    has_many :pennies
  end

  class Organization < ActiveRecord::Base
    has_many :pennies
  end

  def create_penny(attrs)
    p 'testttt'
    new_penny = Penny.create(attrs)
    GPTP::Penny.new(new_penny)
  end

  def get_penny(id)
    penny = Penny.find(id)
    GPTP::Penny.new(new_penny)
  end

  def update_penny(id,data)
    data[:id] = id
    penny = Penny.find_by(id)
    penny.update(data)
  end

  def create_volunteer(attrs)
    new_volunteer = Volunteer.create(attrs)
    GPTP::Volunteer.new(new_volunteer)
  end

  def create_organization(attrs)
    new_organization = Organization.create(attrs)
    GPTP::Organization.new(new_organization)
  end

end

module GPTP
  def self.db
    @__db_instance ||= SQLiteDatabase.new
  end
end
