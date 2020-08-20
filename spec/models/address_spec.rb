require 'rails_helper'
describe Address do
  describe '#create' do
  
    it "全て入力されていればOK" do
      address = build(:address)
      expect(address).to be_valid
    end
    it "postal_codeが空ならNG" do
      address = build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end
    it "postal_codeが意図しない形ならNG（全角）" do
      address = build(:address, postal_code: "１１１１１１１")
      address.valid?
      expect(address.errors[:postal_code]).to include("は不正な値です")
    end
    
    it "prefecture_idが選択されてなければNG" do
      address = build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end
    it "addressが空ならNG" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end
    it "house_numberが空ならNG" do
      address = build(:address, house_number: nil)
      address.valid?
      expect(address.errors[:house_number]).to include("を入力してください")
    end
  end
end