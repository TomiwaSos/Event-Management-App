# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_326_011_914) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comments', force: :cascade do |t|
    t.integer 'event_id'
    t.text 'description'
    t.integer 'author_id'
    t.integer 'status_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'resolved', default: false
  end

  create_table 'events', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.integer 'status_id'
    t.datetime 'resolved_at'
    t.integer 'resolved_by'
    t.boolean 'resolved', default: false
    t.integer 'created_by'
    t.boolean 'active', default: false
    t.datetime 'active_from'
    t.datetime 'active_to'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'statuses', force: :cascade do |t|
    t.string 'name'
    t.string 'colour'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'username'
    t.string 'email'
    t.string 'password_digest'
  end
end
