FactoryBot.define do
  factory :user do
    nickname     {'test'}
    email        {Faker::Internet.email}
    password     {'s00000'}
    password_confirmation  {password}
    first_name   {'てすと'}
    last_name    {'太郎'}
    first_name_kana  {'テスト'}
    last_name_kana  {'タロウ'}
    birthday    {'1988-08-28'}
  end
end

