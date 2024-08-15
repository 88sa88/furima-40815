require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
 before do
  user = FactoryBot.create(:user)
  item = FactoryBot.create(:item, user: user)
  sleep 0.1
  @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: user.id, item_id: item.id)
 end

 describe '購入情報の保存' do
  
  context '内容に問題ない場合' do
    it '全て正しく入力されていれば保存できること' do
      expect(@purchase_shipping_address).to be_valid
    end
    it '建物名が空でも登録できること' do
      @purchase_shipping_address.building = ''
      expect(@purchase_shipping_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it '郵便番号が必須である事' do
      @purchase_shipping_address.post_code = ''
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Post code can't be blank")
    end
    it '郵便番号は3桁-4桁である事' do
      @purchase_shipping_address.post_code = 1111111
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it '郵便番号は半角文字のみなこと' do
      @purchase_shipping_address.post_code = 'あああ-ああああ'
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it '都道府県が必須であること' do
      @purchase_shipping_address.prefecture_id = 1
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
    end
    it '市区町村が必須であること' do
      @purchase_shipping_address.municipality = ''
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Municipality can't be blank")
    end
    it '番地が必須であること' do
      @purchase_shipping_address.street_address = ''
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Street address can't be blank")
    end
    it '電話番号が必須であること' do
      @purchase_shipping_address.telephone_number = ''
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Telephone number can't be blank")
    end
    it '郵便番号が10桁以上のこと' do
      @purchase_shipping_address.telephone_number = 111111111
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Telephone number is invalid. number digits")
    end
    it '郵便番号が11桁未満である事' do
      @purchase_shipping_address.telephone_number = 111111111111
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Telephone number is invalid. number digits")
    end
    it '郵便番号が半角である事' do
      @purchase_shipping_address.telephone_number = 'ああああああああああ'
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Telephone number is invalid. number digits")
    end
    it '郵便番号が数字である事' do
      @purchase_shipping_address.telephone_number = 'aaaaaaaaaaa'
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Telephone number is invalid. number digits")
    end
    it "tokenが空では登録できないこと" do
      @purchase_shipping_address.token = nil
      @purchase_shipping_address.valid?
      expect(@purchase_shipping_address.errors.full_messages).to include("Token can't be blank")
    end
  end
 end

end
