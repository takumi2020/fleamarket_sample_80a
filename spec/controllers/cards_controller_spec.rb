require 'rails_helper'

# describe CardsController, type: :controller do

describe CardsController, type: :controller do
  describe '#pay' do
  
    
    it '決済ができる' do
      customer_mock = double(:customer_mock) # doubleでモック作る
      charge_mock = double(:charge_mock)
      allow(Payjp::Customer).to receive(:create).and_return(customer_mock) # Payjp::Customerのcreateがよばれたらそのモックを返すようにする
      allow(Payjp::Customer).to receive(:retrieve).and_return(customer_mock)
      allow(Payjp::Charge).to receive(:create).and_return(charge_mock)
      allow(customer_mock).to receive(:id).and_return('dummy_customer_id') # そのもっくはidという属性を持っていてそれはdummy_customer_idを返す
      allow(charge_mock).to receive(:id).and_return('dummy_charge_id')
      allow(charge_mock).to receive(:price).and_return(11000)
      expect(status=200).to (@card.blank!)
    
      # あとは普通にexpectするだけ
    end
  end
end
