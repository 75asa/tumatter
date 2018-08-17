class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }

#  ------------------------------------------------------------
#  '/'           →   正規表現の開始
#  '\A'          →   文字列の先頭
#  '[\w+\-.]+'   →   英数字、アンダーバー、プラス、ハイフン、ドット
#                  のいずれかを少なくとも1文字以上繰り返す
#  '@'           →   アットマーク
#  '[a-z\d\-.]+' →   英小文字、数字、ハイフン、ドットのいずれかを
#                  少なくとも1文字以上繰り返す
#  '\.'          →   ドット
#  '[a-z]+'      →   英小文字を少なくも1文字以上繰り返す
#  '\z'          →   文字列の末尾
#  '/'           →   正規表現の終わりを示す
#  'i'           →   大文字小文字を無視するオプション
#  ------------------------------------------------------------

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: { case_sensitive: false }
  has_secure_password            
end
