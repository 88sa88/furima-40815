require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

 describe 'ユーザー新規登録/ユーザー情報' do
  
  context '新規登録できるとき' do
    it '全ての項目が存在し、条件を満たすとき' do
      expect(@user).to be_valid
    end
  end
  context '新規登録できない時' do
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end
    it 'emailが重複している場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include "Email has already been taken"
    end
    it 'メールアドレスは@を含む必要があること' do
      @user.email = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include "Email is invalid"
    end
    it 'パスワードが必須である事' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it 'パスワードは6文字以上での入力が必須であること' do
      @user.password = 's1111'
      @user.password_confirmation = 's1111'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end
    it 'パスワードは半角数字のみでは登録できないこと' do
      @user.password = '111111'
      @user.password_confirmation = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid"
    end
    it 'パスワードは半角英字のみでは登録できないこと' do
      @user.password = 'ssssss'
      @user.password_confirmation = 'ssssss'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid"
    end
    it 'パスワードは全角では登録できないこと' do
      @user.password = 'ああああああ'
      @user.password_confirmation = 'ああああああ'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid"
    end
    it 'パスワードとパスワード（確認）は、値の一致が必須である事' do
      @user.password = '111111'
      @user.password_confirmation = '222222'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
  end
end
 describe '新規登録/本人情報確認' do

  context '新規登録できない時'do
    it '名字が必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end
    it '名前が必須であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end
    it '名字は全角（漢字・ひらがな・カタカナ)での入力が必須であること' do
      @user.first_name = 'saga'
      @user.valid?
      expect(@user.errors.full_messages).to include "First name is invalid"
    end
    it 'お名前は全角（漢字・ひらがな・カタカナ)での入力が必須であること' do
      @user.last_name = 'saga'
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name is invalid"
    end
    it '名字カナ（全角）は名字が必須であること' do
      @user.first_name_kana= ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end
    it 'お名前カナ（全角）は名前が必須であること' do
      @user.last_name_kana= ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank"
    end
    it '名字カナは全角（カタカナ）での入力が必須であること' do
      @user.first_name_kana= 'あべ'
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana is invalid"
    end
    it 'お名前カナは全角（カタカナ）での入力が必須であること' do
      @user.last_name_kana= 'たけし'
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana is invalid"
    end
    it '生年月日が必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Birthday can't be blank"
    end
  end
end

end
