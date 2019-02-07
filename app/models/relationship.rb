class Relationship < ApplicationRecord
  belongs_to :user
  # followがFollowという存在しないクラスを参照することを防ぎ、Userクラスを参照するもの
  belongs_to :follow,class_name: 'User'
end 