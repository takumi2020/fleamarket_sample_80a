class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  # validates :nickname, :mail, :last_name, :family_name, :last_name_kana, :family_name_kana, :birthdate_year, :birthdate_month, :birthdate_day ,presence: true
end
