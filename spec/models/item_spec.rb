require 'rails_helper'
describe Item do
  describe '#create' do
    it "全ての項目が入力された場合に登録できること" do
      item = build(:item)
      expect(item).to be_valid
    end

    it "nameがないと登録できないこと" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "detailがないと登録できないこと" do
      item = build(:item, detail: nil)
      item.valid?
      expect(item.errors[:detail]).to include("を入力してください")
    end

    it "priceがないと登録できないこと" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "priceが100以下だと登録できないこと" do
      item = build(:item, price: 99)
      item.valid?
      expect(item.errors[:price]).to include("は100以上の値にしてください")
    end

    it "priceが100以上だと登録できること" do
      expect(create(:item, price: 101)).to be_valid
    end

    it "brand_idがなくても登録できること" do
      expect(create(:item, brand_id: nil)).to be_valid
    end

    it "size_idがなくても登録できること" do
      expect(create(:item, size_id: nil)).to be_valid
    end

    it "shipping_days_idがないと登録できないこと" do
      item = build(:item, shipping_days_id: nil)
      item.valid?
      expect(item.errors[:shipping_days_id]).to include("を入力してください")
    end

    it "condition_idがないと登録できないこと" do
      item = build(:item, condition_id: nil)
      item.valid?
      expect(item.errors[:condition_id]).to include("を入力してください")
    end

    it "user_idがないと登録できないこと" do
      item = build(:item, user: nil)
      item.valid?
      expect(item.errors[:user]).to include("を入力してください")
    end

    it "sellerがないと登録できないこと" do
      item = build(:item, seller: nil)
      item.valid?
      expect(item.errors[:seller]).to include("を入力してください")
    end

    it "shipping_method_idがないと登録できないこと" do
      item = build(:item, shipping_method_id: nil)
      item.valid?
      expect(item.errors[:shipping_method_id]).to include("を入力してください")
    end

    it "fee_burden_idがないと登録できないこと" do
      item = build(:item, fee_burden_id: nil)
      item.valid?
      expect(item.errors[:fee_burden_id]).to include("を入力してください")
    end

    it "category_idがないと登録できないこと" do
      item = build(:item, category: nil)
      item.valid?
      expect(item.errors[:category]).to include("を入力してください")
    end

    it "item_imagesがないと登録できないこと" do
      item = build(:item_no_image)
      item.valid?
      expect(item.errors[:item_images]).to include("を入力してください")
    end

  end
end