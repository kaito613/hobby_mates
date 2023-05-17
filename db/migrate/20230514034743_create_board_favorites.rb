class CreateBoardFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :board_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true

      t.timestamps  
    end
    add_index :board_favorites, [:user_id, :board_id], unique: :true
  end
end
