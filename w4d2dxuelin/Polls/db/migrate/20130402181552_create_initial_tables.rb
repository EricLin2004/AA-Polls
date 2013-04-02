class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :team_id
    end

    create_table :polls do |t|
      t.integer :creator_id
      t.string :title
    end

    create_table :questions do |t|
      t.integer :poll_id
      t.integer :choice_id
      t.text :body, :limit => 1024
    end

    create_table :choices do |t|
      t.integer :question_id
      t.string :answer
    end

    create_table :responses do |t|
      t.integer :voter_id
      t.integer :choice_id
    end

    create_table :teams do |t|
      t.string :name
    end

    add_index :users, :team_id
    add_index :polls, :creator_id
    add_index :questions, :poll_id
    add_index :questions, :choice_id
    add_index :choices, :question_id
    add_index :responses, :voter_id
    add_index :responses, :choice_id
  end
end
