# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140530160240) do

  create_table "pennies", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "org_id"
    t.string  "time_requirement"
    t.string  "time"
    t.string  "date"
    t.string  "location"
    t.integer "status",           default: 0
    t.integer "vol_id"
  end

end
