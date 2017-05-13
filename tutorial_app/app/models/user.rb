# コントローラ名には複数形を使い、モデル名には単数形を用いる
class User < ActiveRecord::Base

  # email validation 用の正規表現
  # 大文字が定数を意味する
  # Active Recordのコールバック (callback) メソッド 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # メアドの一意性保証のため DB保存前に全て小文字に変換
  before_save { self.email = email.downcase }

  validates(:name, presence: true, length: { maximum: 50 },  uniqueness: true)
  validates(:email, presence: true, length: { maximum: 255 },
   format: { with: VALID_EMAIL_REGEX },  uniqueness: true
) #かっこなくてもOK

  # ハッシュ化したセキュアなパスワードの実装
  has_secure_password
  # パスワードのバリデーション
  validates( :password, presence: true, length: { minimum: 6 } )

  # fixture向けのdigestメソッドの追加用
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end