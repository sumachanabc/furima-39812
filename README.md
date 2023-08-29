# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

# テーブル設計

## users テーブル

| Column           | Type   | Options             |
| ---------------- | ------ | ------------------- |
| nickname         | string | null: false         |
| email            | string | null: false, unique |
| password         | string | null: false         |
| first_name       | string | null: false         |
| family_name      | string | null: false         |
| read_first_name  | string | null: false         |
| read_family_name | string | null: false         |
| date_of_birth    | date   | null: false         |

### Association

- has_many :items
- has_many :comments
- has_one :purchase
- has_one :shipping_address

## items テーブル

| Column             | Type    | Options                        |
| ------------------ | ------- | ------------------------------ |
| image              | string  | null: false                    |
| item_name          | string  | null: false                    |
| description        | text    | null: false                    |
| category           | integer | null: false, foreign_key: true |
| condition          | string  | null: false                    |
| shipping_details   | text    | null: false                    |
| shipping_location  | string  | null: false                    |
| shipping_timeframe | string  | null: false                    |
| price              | integer | null: false                    |
| user_id            | integer | null: false, foreign_key: true |

### Association

- has_many :comments
- belongs_to :user

## comments テーブル

| Column  | Type    | Options                        |
| ------- | ------- | ------------------------------ |
| text    | text    | null: false                    |
| user_id | integer | null: false, foreign_key: true |
| item_id | integer | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## shipping_addresses テーブル

| Column         | Type    | Options                        |
| -------------- | ------- | ------------------------------ |
| postal_code    | string  | null: false                    |
| prefecture     | string  | null: false                    |
| city           | string  | null: false                    |
| street_address | string  | null: false                    |
| building_name  | string  |                                |
| phone_number   | string  | null: false                    |
| user_id        | integer | null: false, foreign_key: true |

### Association

- belongs_to :user

## purchases テーブル

| Column        | Type    | Options                        |
| ------------- | ------- | ------------------------------ |
| card_number   | string  | null: false                    |
| expiry_date   | date    | null: false, foreign_key: true |
| security_code | string  | null: false, foreign_key: true |
| user_id       | integer | null: false, foreign_key: true |

### Association

- belongs_to :user
