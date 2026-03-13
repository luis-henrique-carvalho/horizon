class CreateMilestones < ActiveRecord::Migration[8.1]
  def change
    create_table :milestones do |t|
      t.string :title
      t.integer :order
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
