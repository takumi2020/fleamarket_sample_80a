require 'rails_helper'
describe User do
  describe '#create' do
    it "ニックネームなしでは無効です" do
      user = User.new(nickname: "", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000", last_name: '太郎', family_name: '山田', last_name_kana: 'タロウ', family_name_kana: 'ヤマダ', birthday: '1985-01-01')
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end
  end
end