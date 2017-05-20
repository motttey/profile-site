# コントローラ名には複数形を使い、モデル名には単数形を用いる
class User < ActiveRecord::Base

  attr_accessor :remember_token, :activation_token

  # Account Activation用のコード
  before_save { email.downcase! }
  before_create :create_activation_digest

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
  # update時の空を許可する
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # fixture向けのdigestメソッドの追加用
  # 渡された文字列のハッシュ値を返す
  # 新規ユーザ登録時にはオブジェクト生成時のhas_secure_passwordのバリデーションが実行される
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 永続ログイン用の記憶トークン生成
    # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # ローカル変数にしないためselfをつける, selfはUserクラスを指す
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    # Rubyのメタプログラミング機能により複数のdigestに対応
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効にする
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  private

    # メールアドレスをすべて小文字にする
    # def downcase_email
    #   self.email = email.downcase
    # end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end