# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


#テーブル設計
#users
| Column             | Type            | Options                            |
|--------------------|-----------------|------------------------------------|
|email               | string          |null:false, unique: true            |
|encrypted_password  | string          |null:false                          |
|nickname            | string          |null:false                          |
|first_name          | string          |null:false                          |
|last_name           | string          |null:false                          |
|first_name_kana     | string          |null:false                          |
|last_name_kana      | string          |null:false                          |
|birthday            | date            |null:false                          |
### Association

- has_many :items
- has_many :purchases



#itemsテーブル
| Column             | Type            | Options                            |
|--------------------|-----------------|------------------------------------|
|item_name           | string          |null:false                          |
|explanation         | text            |null:false                          |
|category_id         | integer         |null:false                          |
|situation_id        | integer         |null:false                          |
|postage_id          | integer         |null:false                          |
|prefecture_id       | integer         |null:false                          |
|shipping_day_id     | integer         |null:false                          |
|price               | integer         |null:false                          |
|user                | reference       |null:false, foreign_key: true       |

### Association

- belongs_to :user
- has_one :purchase

#purchasesテーブル
| Column             | Type            | Options                            |
|--------------------|-----------------|------------------------------------|
|user                | reference       |null:false, foreign_key: true       |
|item                | reference       |null:false, foreign_key: true       |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address


#shipping_addresssテーブル
| Column             | Type            | Options                            |
|--------------------|-----------------|------------------------------------|
|post_code           | string          |null:false                          |
|prefecture_id       | integer         |null:false                          |
|municipality        | string          |null:false                          |
|street_address      | string          |null:false                          |
|building            | string          |                                    |
|telephone_number    | string          |null:false                          |
|purchase            | reference       |null:false, foreign_key: true       |

### Association

- belongs_to :purchase