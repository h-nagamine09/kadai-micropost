class User < ApplicationRecord
  before_save { self.email.downcase! }
  #downcase!は自動的に小文字に変換
  validates :name, presence: true, length: { maximum: 50 }#バリデーションの設定
  #カラを許さず５０文字以内
  validates :email, presence: true, length: { maximum: 255 },#バリデーションの設定
  #カラを許さず255字以内
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },#正規表現
                    uniqueness: { case_sensitive: false }#重複を許さないバリデーション
                    #case_sensitive: false 大文字小文字を区別しない
  has_secure_password
  
  # 一対多の表現。Userからみた時複数存在するので has_many :micropostsとする
  has_many :microposts
  # 多対多の図の右半分にいる自分がフォローしているUserへの参照
  has_many :relationships
  # 自分がフォローしているUser達を取得
  has_many :followings, through: :relationships, source: :follow # < user.followersと書けば該当のuserがフォローしているUser達を取得できる
  # 多対多の図の左半分にいるUserからフォローされているという関係への参照(自分をフォローしているUserへの参照)
  has_many :reverses_of_relationship, class_name: 'Relationship',foreign_key: 'follow_id'
  # 自分をフォローしているUser達を取得
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  # 中間テーブルを経由して相手の情報を取得できるようにするためには'through'を使用する
  
  # フォローアンフォローメソッド
  def follow(other_user)
    # フォローしようとしているother_userが自分自身ではないかを検証している
    unless self == other_user
    # 見つかればRelationを返し、見つからなければself.relationships.create(follow_id: other_user.id) としてフォロー関係を保存(create = build + save)することができる
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end 
  end
  
  def unfollow(other_user)
    # フォローがあればアンフォロー
    relationship = self.relationships.find_by(follow_id: other_user.id)
    # relationshipが存在すればdestoroyする
    relationship.destroy if relationship
  end 
  
  def following?(other_user)
    # self.followingsによりフォローしているUser達を取得し、include?(other_user)によってother_userが含まれていないかを確認している。
    # 含まれている場合はtrueを返し、含まれていない場合はfalseを返す
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    # UserがフォローしているUserのidの配列を取得。さらに自分自身のself.idもデータ型を合わせるために[self.id]と配列変換して追加
    Micropost.where(user_id: self.following_ids + [self.id])
    # Micropost.where(user_id: フォローユーザ + 自分自身)
  end
end



