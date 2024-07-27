require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'item出品機能' do

    context '出品したものが保存できるとき' do
      it '必要な情報を適切に入力して出品するボタンを押すと、商品情報がデータベースに保存される'  do
        expect(@item).to be_valid
      end
    end

    context '出品したものが保存できないとき' do
      it '画像が空だと保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空だと保存できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明が空だと保存できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it 'カテゴリーの情報が必須である事' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態の情報が必須である事' do
        @item.situation_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Situation can't be blank")
      end
      it '送料の負担の情報が必須である事' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end
      it '発送元の地域の情報が必須である事' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数の情報が必須である事' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it '価格の情報が必須である事' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が300円以上である事' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it '価格が9,999,999円以下である事' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it '価格は全角では保存できないこと' do
        @item.price = 'あああああああ'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it '価格は半角英字では保存できないこと' do
        @item.price = 'aaaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
    
  end

  
end
