require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname, email, password, password_confirmation, first_name, family_name, read_first_name, read_family_name, date_of_birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = 'mismatched_password'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが英字のみの場合は登録できない' do
        @user.password = 'password'
        @user.password_confirmation = 'password'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英字と数字の両方を含む必要があります')
      end

      it 'passwordが数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英字と数字の両方を含む必要があります')
      end

      it 'passwordが全角文字を含む場合は登録できない' do
        @user.password = 'パスワードA1'
        @user.password_confirmation = 'パスワードA1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英字と数字の両方を含む必要があります')
      end

      it '重複したemailが存在する場合は登録できない' do
        FactoryBot.create(:user, email: @user.email)
        @user.valid?
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'invalid_email.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = 'a' * 129
        @user.password_confirmation = 'a' * 129
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'read_first_nameが空では登録できない' do
        @user.read_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read first name can't be blank")
      end

      it 'read_family_nameが空では登録できない' do
        @user.read_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Read family name can't be blank")
      end

      it 'date_of_birthが空では登録できない' do
        @user.date_of_birth = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end

      it 'first_nameが全角文字でないと登録できない' do
        @user.first_name = 'Taro' # 全角でない名前
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角文字で入力してください')
      end

      it 'family_nameが全角文字でないと登録できない' do
        @user.family_name = 'Tanaka' # 全角でない名前
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name は全角文字で入力してください')
      end

      it 'read_first_nameがカタカナでないと登録できない' do
        @user.read_first_name = 'たろう' # カタカナでない名前カナ
        @user.valid?
        expect(@user.errors.full_messages).to include('Read first name はカタカナで入力してください')
      end

      it 'read_family_nameがカタカナでないと登録できない' do
        @user.read_family_name = 'たなか' # カタカナでない名前カナ
        @user.valid?
        expect(@user.errors.full_messages).to include('Read family name はカタカナで入力してください')
      end
    end
  end
end
