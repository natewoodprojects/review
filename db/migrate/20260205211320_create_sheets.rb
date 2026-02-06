class CreateSheets < ActiveRecord::Migration[8.1]
  def change
    create_table :sheets do |t|
      t.string :title
      t.string :file

      t.timestamps
    end
  end
end
