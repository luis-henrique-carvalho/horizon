class CreateSubtasks < ActiveRecord::Migration[8.1]
  def change
    create_table :subtasks do |t|
      t.string :title
      t.boolean :completed, default: false
      t.datetime :completed_at
      t.references :milestone, null: false, foreign_key: true

      t.timestamps
    end
  end
end
