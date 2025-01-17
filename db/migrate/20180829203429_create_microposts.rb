class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    # 1つの配列に2つのキーを同時に扱う複合キーインデックスを作成
    add_index :microposts, [:user_id, :created_at]
  end
end
