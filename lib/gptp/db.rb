require 'pry'
class GPTP::DB
  attr_writer :db
  def initialize
    # Database method
    @db = SQLite3::Database.new "test.db"

    @db.execute( <<-SQL
      CREATE TABLE if not exists pennies (
        id integer,
        name text NOT NULL UNIQUE,
        description text NOT NULL,
        company text NOT NULL,
        time_requirement text NOT NULL,
        time text,
        day text,
        location text,
        status text,
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
      "INSERT INTO pennies (name, description, company, time_requirement, time, day, location)
      VALUES (?,?,?,?,?,?,?)", data[:name], data[:description], data[:company], data[:time_requirement], data[:time], data[:day], data[:location], 0
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
      company: data[3],
      time_requirement: data[4],
      time: data[5],
      day: data[6],
      location: data[7],
      status: data[8]
    }

    build_penny(data_hash)
  end

  def update_move(id,data)

    @db.execute(
      "UPDATE pennies
      SET time = ?
      WHERE id = ?", data[:time], id
    )

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
      company: data[3],
      time_requirement: data[4],
      time: data[5],
      day: data[6],
      location: data[7],
      status: data[8]
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
      company: data[3],
      time_requirement: data[4],
      time: data[5],
      day: data[6],
      location: data[7],
      status: data[8]
    }

    build_penny(data_hash)
  end

  # Volunteer CRUD methods
  def create_volunteer(data)
    @db.execute("INSERT INTO volunteers(name, password, age) values('#{data[:name]}', '#{data[:password]}', '#{data[:age]}');")
    data[:id] = @db.execute('SELECT last_insert_rowid();').flatten.first
    build_volunteer(data)
  end

  def get_volunteer(name)
    volunteer = @db.execute("SELECT * FROM volunteers where name='#{name}';").flatten
    hash = {id: volunteer[0], name: volunteer[1], password: volunteer[2], age: volunteer[3]}
    build_volunteer(hash)
  end

  def update_volunteer(name, data)
    data.each do |key, value|
      @db.execute("UPDATE volunteers SET '#{key}' = '#{value}' where name='#{name}';")
    end
    get_volunteer(name)
  end

  def build_volunteer(data)
    GPTP::Volunteer.new(data[:id], data[:name], data[:password], data[:age])
  end

  # testing helper method
  def clear_table(table_name)
    @db.execute("delete from '#{table_name}';")
  end
end

module GPTP
  def self.db
    @__db_instance ||= DB.new
  end
end
