class Micropost < ApplicationRecord
  # belong_to :userはユーザーとMicropostの一対多を表現している。このコードのおかげでmicropost.userとすると
  # micropostインスタンスを持っているUserを取得することができる
   belongs_to :user
   has_many :favorites
   has_many :users, through: :favorites
  
  validates :content,presence: true, length: {maximum: 255} 

end
