class CreateColors < ActiveRecord::Migration[8.0]
  def change
    create_table :colors do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
