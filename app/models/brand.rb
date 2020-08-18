class Brand < ActiveHash::Base
  self.data = [
    {id:1, name: 'プラダ'}, {id:2, name: 'エルメス'}, {id:3, name: 'バレンシアガ'},
    {id:4, name: 'フェンディ'}, {id:5, name: 'サン・ローラン'}, {id:6, name: 'アルマーニ'}
  ]

  include ActiveHash::Associations
  has_many :items
end
