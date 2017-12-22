class CreateTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :translations do |t|
      t.string :text
      t.integer :language_id
      t.integer :word_id

      t.timestamps
    end
  end
end
