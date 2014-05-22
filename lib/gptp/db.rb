require 'pry'
class GPTP::DB
  attr_writer :db
  def initialize(filename)
    # Database method
    @db = SQLite3::Database.new(filename)

    @db.execute( <<-SQL
      CREATE TABLE if not exists pennies (
        id integer,
        name text NOT NULL UNIQUE,
        description text NOT NULL,
        org_id integer NOT NULL,
        time_requirement text NOT NULL,
        time text,
        date text,
        location text,
        status integer,
        vol_id integer,
        PRIMARY KEY (id)
      )
      SQL
    )
    @db.execute( <<-SQL
      CREATE TABLE if not exists volunteers(
        id integer,
        name text,
        password text,
        age integer,
        email text,
        PRIMARY KEY(id)
        )
      SQL
    )
    @db.execute( <<-SQL
      CREATE TABLE if not exists organizations(
        id integer,
        name text,
        password text,
        description text,
        phone_num integer,
        address text,
        email text,
        PRIMARY KEY(id)
        )
      SQL
    )
    @db.execute( <<-SQL
      CREATE TABLE if not exists volunteers_pennies(
        id integer,
        penny_id integer,
        vol_id integer,
        PRIMARY KEY(id)
        )
      SQL
    )
  end

  # Penny CRUD methods
  def build_penny(data)
    GPTP::Penny.new(data)
  end

  def create_penny(data)
    @db.execute(
      "INSERT INTO pennies (name, description, org_id, time_requirement, time, date, location, status, vol_id)
      VALUES (?,?,?,?,?,?,?,?,?)", data[:name], data[:description], data[:org_id], data[:time_requirement], data[:time], data[:date], data[:location], data[:status], data[:vol_id]
    )

    data =
      @db.execute(
        "SELECT * FROM pennies
        WHERE id = last_insert_rowid()"
      )

    data.flatten!

    data_hash = {
      id: data[0],
      name: data[1],
      description: data[2],
      org_id: data[3],
      time_requirement: data[4],
      time: data[5],
      date: data[6],
      location: data[7],
      status: data[8],
      vol_id: data[9]
    }

    build_penny(data_hash)
  end

  def update_penny(id,data)

    # @db.execute(
    #   "UPDATE pennies
    #   SET status = ?
    #   WHERE id = ?", data[:status], id
    # )
    data.each do |key, value|
      @db.execute("UPDATE pennies SET '#{key}' = '#{value}' where id= ?", id)
    end

    data =
      @db.execute(
        "SELECT * FROM pennies
        WHERE id = ?", id
      )
    data.flatten!

    data_hash = {
      id: data[0],
      name: data[1],
      description: data[2],
      org_id: data[3],
      time_requirement: data[4],
      time: data[5],
      date: data[6],
      location: data[7],
      status: data[8],
      vol_id: data[9]
    }

    build_penny(data_hash)

  end

  def get_penny(id)

    data =
      @db.execute(
        "SELECT * FROM pennies
        WHERE id = ?", id
      )

    data.flatten!

    data_hash = {
      id: data[0],
      name: data[1],
      description: data[2],
      org_id: data[3],
      time_requirement: data[4],
      time: data[5],
      date: data[6],
      location: data[7],
      status: data[8],
      vol_id: data[9]
    }

    build_penny(data_hash)
  end

  # Volunteer CRUD methods
  def create_volunteer(data)
    @db.execute("INSERT INTO volunteers(name, password, age, email) values('#{data[:name]}', '#{data[:password]}', '#{data[:age]}', '#{data[:email]}');")
    data[:id] = @db.execute('SELECT last_insert_rowid();').flatten.first
    build_volunteer(data)
  end

  def get_volunteer(email)
    volunteer = @db.execute("SELECT * FROM volunteers where name='#{email}';").flatten
    hash = {id: volunteer[0], name: volunteer[1], password: volunteer[2], age: volunteer[3], email: volunteer[4]}
    build_volunteer(hash)
  end

  def update_volunteer(id, data)
    data.each do |key, value|
      @db.execute("UPDATE volunteers SET '#{key}' = '#{value}' where name='#{name}';")
    end
    get_volunteer(name)
  end

  def remove_volunteer(email)
    @db.execute("DELETE FROM volunteers where name='#{name}';")
  end

  def build_volunteer(data)
    GPTP::Volunteer.new(data[:id], data[:name], data[:password], data[:age], data[:email])
  end

  # Organizations CRUD methods
  def create_organization(data)
    @db.execute("INSERT INTO organizations(name, password, description, phone_num, address, email) values('#{data[:name]}', '#{data[:password]}', '#{data[:description]}', '#{data[:phone_num]}', '#{data[:address]}', '#{data[:email]}');")
    data[:id] = @db.execute('SELECT last_insert_rowid();').flatten.first
    build_organization(data)
  end

  def get_organization(email)
    organization = @db.execute("SELECT * FROM organizations where name='#{email}';").flatten
    hash = {id: organization[0], name: organization[1], password: organization[2], description: organization[3], phone_num: organization[4], address: organization[5], email: organization[6]}
    build_organization(hash)
  end

  def build_organization(data)
    GPTP::Organization.new(data[:id], data[:name], data[:password], data[:description], data[:phone_num], data[:address], data[:email])
  end

  # testing helper method
  def clear_table(table_name)
    @db.execute("delete from '#{table_name}';")
  end
end

module GPTP
  def self.db
    @__db_instance ||= DB.new("gptp.db")
  end
end
