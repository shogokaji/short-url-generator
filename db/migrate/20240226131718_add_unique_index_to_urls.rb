class AddUniqueIndexToUrls < ActiveRecord::Migration[7.1]
  def change
    add_index :urls, :original, unique: true
    add_index :urls, :digest, unique: true
  end
end
