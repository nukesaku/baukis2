class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :email, null: false, comment: 'メールアドレス'
      t.string :family_name, null: false, comment: '姓'
      t.string :given_name, null: false, comment: '名'
      t.string :family_name_kana, null: false, comment: '姓（セイ）'
      t.string :given_name_kana, null: false, comment: '名（メイ）'
      t.string :gender, comment: '性別'
      t.date :birthday, comment: '誕生日'
      t.string :hashed_password, comment: 'パスワード'

      t.timestamps
    end

    add_index :customers, "LOWER(email)", unique: true
    add_index :customers, [ :family_name_kana, :given_name_kana ]
  end
end
