class AddNoteToFavorites < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :note, :string
  end
end
