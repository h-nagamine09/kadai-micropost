class Micropost < ApplicationRecord
  belongs_to :user
  # belong_to :userはユーザーとMicropostの一対多を表現している。このコードのおかげでmicropost.userとすると
  # micropostインスタンスを持っているUserを取得することができる
  
  validates :content,presence: true, length: {maximum: 255} 
  #バリデーション
end
