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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130403003224) do

  create_table "choices", :force => true do |t|
    t.integer "question_id"
    t.string  "answer"
  end

  add_index "choices", ["question_id"], :name => "index_choices_on_question_id"

  create_table "poll_histories", :force => true do |t|
    t.integer "voter_id"
    t.integer "poll_id"
  end

  add_index "poll_histories", ["poll_id"], :name => "index_poll_histories_on_poll_id"
  add_index "poll_histories", ["voter_id"], :name => "index_poll_histories_on_voter_id"

  create_table "polls", :force => true do |t|
    t.integer "creator_id"
    t.string  "title"
  end

  add_index "polls", ["creator_id"], :name => "index_polls_on_creator_id"

  create_table "questions", :force => true do |t|
    t.integer "poll_id"
    t.text    "body",    :limit => 1024
  end

  add_index "questions", ["poll_id"], :name => "index_questions_on_poll_id"

  create_table "responses", :force => true do |t|
    t.integer "voter_id"
    t.integer "choice_id"
  end

  add_index "responses", ["choice_id"], :name => "index_responses_on_choice_id"
  add_index "responses", ["voter_id"], :name => "index_responses_on_voter_id"

  create_table "teams", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string  "name"
    t.integer "team_id"
  end

  add_index "users", ["team_id"], :name => "index_users_on_team_id"

end
