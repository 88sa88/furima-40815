require 'rails_helper'

RSpec.describe User, type: :model do
 describe 'ユーザー新規登録/ユーザー情報' do
  it 'nicknameが空だと登録できない' do
    user = FactoryBot.build(:user)
    user.nickname = ''
    user.valid?
    expect(user.errors.full_messages).to include "Nickname can't be blank"
  end
  it 'emailが空では登録できない' do
    user = FactoryBot.build(:user)
    user.email = ''
    user.valid?
    expect(user.errors.full_messages).to include "Email can't be blank"
  end
  it 'emailが重複している場合は登録できない' do
    FactoryBot.create(:user, email: 'test@test')
    user = FactoryBot.build(:user)
    user.valid?
    expect(user.errors.full_messages).to include "Email has already been taken"
  end
  it 'メールアドレスは@を含む必要があること' do
    user = FactoryBot.build(:user)
    user.email = '111111'
    user.valid?
    expect(user.errors.full_messages).to include "Email is invalid"
  end
  it 'パスワードが必須である事' do
    user = FactoryBot.build(:user)
    user.password = ''
    user.valid?
    expect(user.errors.full_messages).to include "Password can't be blank"
  end
  it 'パスワードは6文字以上での入力が必須であること' do
    user = FactoryBot.build(:user)
    user.password = 's1111'
    user.password_confirmation = 's1111'
    user.valid?
    expect(user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
  end
  it 'パスワードは半角英数字混合での入力が必須であること' do
    user = FactoryBot.build(:user)
    user.password = '111111'
    user.password_confirmation = '111111'
    user.valid?
    expect(user.errors.full_messages).to include "Password is invalid"
  end
  it 'パスワードとパスワード（確認）は、値の一致が必須である事' do
    user = FactoryBot.build(:user)
    user.password = '111111'
    user.password_confirmation = '222222'
    user.valid?
    expect(user.errors.full_messages).to include "Password confirmation doesn't match Password"
  end
 end
 describe '新規登録/本人情報確認' do

  it '名字が必須であること' do
    user = FactoryBot.build(:user)
    user.first_name = ''
    user.valid?
    expect(user.errors.full_messages).to include "First name can't be blank"
  end
  it '名前が必須であること' do
    user = FactoryBot.build(:user)
    user.last_name = ''
    user.valid?
    expect(user.errors.full_messages).to include "Last name can't be blank"
  end
  it 'お名前は全角（漢字・ひらがな・カタカナ)での入力が必須であること' do
    user = FactoryBot.build(:user)
    user.last_name = 'saga'
    user.valid?
    expect(user.errors.full_messages).to include "Last name is invalid"
  end
  it 'お名前カナ（全角）は名字が必須であること' do
    user = FactoryBot.build(:user)
    user.first_name_kana= ''
    user.valid?
    expect(user.errors.full_messages).to include "First name kana can't be blank"
  end
  it 'お名前カナ（全角）は名前が必須であること' do
    user = FactoryBot.build(:user)
    user.last_name_kana= ''
    user.valid?
    expect(user.errors.full_messages).to include "Last name kana can't be blank"
  end
  it 'お名前カナ（全角）は全角（カタカナ）での入力が必須であること' do
    user = FactoryBot.build(:user)
    user.last_name_kana= 'たけし'
    user.valid?
    expect(user.errors.full_messages).to include "Last name kana is invalid"
  end
  it '生年月日が必須であること' do
    user = FactoryBot.build(:user)
    user.birthday = ''
    user.valid?
    expect(user.errors.full_messages).to include "Birthday can't be blank"
  end
 end


end
