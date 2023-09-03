class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
end
