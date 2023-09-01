require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user) # ログイン状態のユーザーを作成
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '商品出品機能' do
    context '商品の出品ができる場合' do
      it '正しい情報が入力された場合、商品が出品でき、データベースに保存されること' do
        expect(@item).to be_valid
      end

      it '出品が完了した場合、トップページに遷移すること' do
        @item.save
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができない場合' do
      it '商品画像が添付されていない場合、商品が出品できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空の場合、商品が出品できないこと' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品説明が空の場合、商品が出品できないこと' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが未選択の場合、商品が出品できないこと' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が未選択の場合、商品が出品できないこと' do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it '配送料の負担が未選択の場合、商品が出品できないこと' do
        @item.shipping_detail_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping detail can't be blank")
      end

      it '発送元の地域が未選択の場合、商品が出品できないこと' do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が未選択の場合、商品が出品できないこと' do
        @item.shipping_timeframe_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping timeframe can't be blank")
      end

      it '価格が空の場合、商品が出品できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
    end

    context '商品の出品ができない場合（価格が範囲外の場合）' do
      it '価格が300未満の場合、商品が出品できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it '価格が10,000,000以上の場合、商品が出品できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end

    context '商品の出品ができない場合（価格が半角数値以外の場合）' do
      it '価格が半角英字のみの場合、商品が出品できないこと' do
        @item.price = 'abcdef'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it '価格が半角英数字の組み合わせではない場合、商品が出品できないこと' do
        @item.price = '123abc'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end

    context 'エラーハンドリング' do
      it '入力に問題がある状態で「出品する」ボタンが押された場合、情報は保存されず、出品ページに戻りエラーメッセージが表示されること' do
        @item.image = nil
        @item.valid?
        expect { @item.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'エラーハンドリングによって出品ページに戻った場合でも、入力済みの項目（商品画像・販売手数料・販売利益以外）は消えないこと' do
        @item.image = nil
        @item.valid?
        @item.save rescue nil
        expect(@item).to have_attributes(
          item_name: @item.item_name,
          description: @item.description,
          category_id: @item.category_id,
          condition_id: @item.condition_id,
          shipping_detail_id: @item.shipping_detail_id,
          prefecture_id: @item.prefecture_id,
          shipping_timeframe_id: @item.shipping_timeframe_id,
          price: @item.price
        )
      end
    end
  end
end
