class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)

  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :status, :created_at)
  end
end
