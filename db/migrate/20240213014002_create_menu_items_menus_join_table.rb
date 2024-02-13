class CreateMenuItemsMenusJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.references  :menu
      t.references  :menu_item
      t.decimal     :price

      t.timestamps
    end

    add_index :prices, [:menu_id, :menu_item_id]

    #the price and menu associated with a menu_item are now stored in the prices table
    remove_column :menu_items, :price
    remove_column :menu_items, :menu_id
  end
end
