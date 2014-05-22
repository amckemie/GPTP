require 'pry'
class GPTP::DB

  def initialize
    # Database method
    @db = SQLite3::Database.new "test.db"

    @db.execute( <<-SQL
      CREATE TABLE if not exists pennies (
        id integer,
        name string NOT NULL UNIQUE,
        description string NOT NULL,
        company string NOT NULL,
        time_requirement string NOT NULL,
        time string,
        day string,
        location string,
        status string,
        PRIMARY KEY (id)
      )
      SQL
    )

  end

  def build_penny(data)
    RPS::Penny.new(data)
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
end

module GPTP
  def self.db
    @__db_instance ||= DB.new
  end
end
