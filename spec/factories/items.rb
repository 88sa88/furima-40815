FactoryBot.define do
  factory :item do
    item_name       {'test'}
    explanation     {'test'}
    category_id     {2}
    situation_id    {2}
    postage_id      {2}
    prefecture_id   {2}
    shipping_day_id {2}
    price           {600}
    user            {association :user }

  end
end
