# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_171_221_171_057) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'posts', force: :cascade do |t|
    t.text 'description', null: false
    t.datetime 'date', null: false
    t.bigint 'user_id'
    t.bigint 'topic_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['topic_id'], name: 'index_posts_on_topic_id'
    t.index %w[user_id topic_id], name: 'index_posts_on_user_id_and_topic_id'
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end

  create_table 'topics', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'description', null: false
    t.datetime 'date', null: false
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_topics_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'name', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'jti', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['jti'], name: 'index_users_on_jti', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'posts', 'topics'
  add_foreign_key 'posts', 'users'
  add_foreign_key 'topics', 'users'
end
