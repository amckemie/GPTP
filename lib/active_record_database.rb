require 'sqlite3'

class GPTP::ActiveRecordDatabase

  def initialize
    ActiveRecord::Base.establish_connection(
      :adapter => 'postgresql',
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

  # Penny CRUD Methods
  def build_penny(penny)
    GPTP::Penny.new(penny.id, penny.name, penny.description, penny.org_id, penny.time_requirement, penny.time, penny.date, penny.location, penny.status, penny.vol_id)
  end

  def create_penny(attrs)
    new_penny = Penny.create(attrs)
    build_penny(new_penny)
  end

  def get_penny(id)
    penny = Penny.find(id)
    if penny
      build_penny(penny)
    else
      penny
    end
  end

  def update_penny(id, data)
    penny = Penny.find(id)
    if penny
      penny.update(data)
      build_penny(penny)
    else
      penny
    end
  end

  def destroy_penny(id)
    penny = Penny.find(id)
    penny.destroy
  end

  # Volunteer CRUD methods
  def build_volunteer(volunteer)
    GPTP::Volunteer.new(volunteer.id, volunteer.name, volunteer.password, volunteer.age, volunteer.email)
  end

  def create_volunteer(attrs)
    volunteer = Volunteer.create(attrs)
    build_volunteer(volunteer)
  end

  def get_volunteer(email)
    volunteer = Volunteer.find_by(email: email)
    if volunteer
      build_volunteer(volunteer)
    else
      volunteer
    end
  end

  def update_volunteer(email, data)
    volunteer = Volunteer.find_by(email: email)
    if volunteer
      volunteer.update(data)
      build_volunteer(volunteer)
    else
      volunteer
    end
  end

  def remove_volunteer(email)
    volunteer = Volunteer.find_by(email: email)
    volunteer.destroy
  end

  def list_volunteers
    all_volunteers = []
    Volunteer.all.each do |volunteer|
      all_volunteers << build_volunteer(volunteer)
    end
    all_volunteers
  end

  def create_organization(attrs)
    new_organization = Organization.create(attrs)
    GPTP::Organization.new(new_organization)
  end

  # Organization CRUD methods
  def build_organization(organization)
    GPTP::Organization.new(organization.id, organization.name, organization.password, organization.description, organization.phone_num, organization.address, organization.email)
  end

  def create_organization(attrs)
    org = Organization.create(attrs)
    build_organization(org)
  end

  def get_organization(email)
    organization = Organization.find_by(email: email)
    if organization
      build_organization(organization)
    else
      organization
    end
  end

  def update_organization(email, data)
    organization = Organization.find_by(email: email)
    if organization
      organization.update(data)
      build_organization(organization)
    else
      organization
    end
  end

  def remove_organization(email)
    organization = Organization.find_by(email: email)
    organization.destroy
  end

  def list_organizations
    all_organizations = []
    Organization.all.each do |organization|
      all_organizations << build_organization(organization)
    end
    all_organizations
  end
end

module GPTP
  def self.db
    @__db_instance ||= ActiveRecordDatabase.new
  end
end
