class NewTableForCustomValidation < ActiveRecord::Migration
  def change
    create_table :poll_histories do |t|
      t.integer :voter_id
      t.integer :poll_id
    end

    add_index :poll_histories, :poll_id
    add_index :poll_histories, :voter_id
  end
end
