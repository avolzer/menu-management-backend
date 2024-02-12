class CreateMenuItems < ActiveRecord::Migration[7.1]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.decimal :price
      t.references :menu, foreign_key: true

      t.timestamps
    end
  end
end
π