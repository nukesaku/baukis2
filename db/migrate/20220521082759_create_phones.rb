class CreatePhones < ActiveRecord::Migration[6.0]
  def change
    create_table :phones do |t|
      t.references :customer, null: false
      t.references :address
      t.string :number, null: false, comment: '電話番号' # 電話番号
      t.string :number_for_index, null: false, comment: '検索用電話番号' # 検索用電話番号
      t.boolean :primary, null: false, default: false, comment: '優先フラグ' # 優先フラグ
      
      t.timestamps
    end

    add_index :phones, :number_for_index
    add_foreign_key :phones, :customers
    add_foreign_key :phones, :addresses
  end
end
