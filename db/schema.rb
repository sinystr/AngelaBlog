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

ActiveRecord::Schema.define(version: 20_170_815_102_521) do
  create_table 'articles', force: :cascade do |t|
    t.string 'picture'
    t.string 'title_bg'
    t.string 'title_en'
    t.string 'text_bg'
    t.string 'text_en'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'active', default: false
  end

  create_table 'articles_tags', force: :cascade do |t|
    t.integer 'article_id'
    t.integer 'tag_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'text'
    t.integer 'article_id'
    t.integer 'user_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'name'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'password'
    t.string 'name'
    t.integer 'rank'
    t.string 'secret_answer'
    t.string 'password_salt'
  end
end
