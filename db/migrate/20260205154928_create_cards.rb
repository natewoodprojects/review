class CreateCards < ActiveRecord::Migration[8.1]
  def change
    create_table :cards do |t|
      t.string :question
      t.string :answer
      t.string :deck

      t.timestamps
    end
  end
end
