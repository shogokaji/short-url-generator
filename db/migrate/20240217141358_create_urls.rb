class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.text :original, null: false
      t.string :digest, null: false

      t.timestamps
    end
  end
end
