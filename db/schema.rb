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

ActiveRecord::Schema.define(version: 20151201202213) do

  create_table "junior_stories", force: :cascade do |t|
    t.string   "job"
    t.string   "happy_in_job"
    t.text     "happy_info"
    t.string   "gender"
    t.string   "city"
    t.string   "country"
    t.string   "days_per_week"
    t.string   "salary"
    t.string   "currency"
    t.string   "technology"
    t.string   "focus"
    t.integer  "age"
    t.string   "years_working_total"
    t.string   "years_working_at_job"
    t.string   "education"
    t.string   "first_job"
    t.string   "remote"
    t.string   "tech_team_size"
    t.string   "company_size"
    t.integer  "company_age"
    t.boolean  "person_of_colour",     default: false
    t.text     "other"
    t.boolean  "publishing_consent",   default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "freelancer"
  end

end
