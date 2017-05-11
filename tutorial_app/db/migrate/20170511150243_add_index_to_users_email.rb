# メールアドレスの一意性を強制するためのマイグレーション
# マイグレーション: アプリケーションのデータモデルの修正, SQL使わずにできる
class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def change
  	# user, emailカラムにインデックスを追加, 一意性を強制
	add_index :users, :email, unique: true
  end
end
