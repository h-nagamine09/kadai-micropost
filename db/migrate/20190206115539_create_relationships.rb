class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: {to_table: :users } #{to_table: :users }は外部キーとしてusersテーブルを参照する。

      t.timestamps
      
      # user_idとfollow_idペアで重複するものが保存されないようにするデータベースの設定
      t.index [:user_id, :follow_id],unique: true
    end
  end
end

#t.referencesは別テーブルを参照させるという意味