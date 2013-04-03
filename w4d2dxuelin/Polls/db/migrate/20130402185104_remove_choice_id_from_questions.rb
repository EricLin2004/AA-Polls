class RemoveChoiceIdFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :choice_id
  end
end
