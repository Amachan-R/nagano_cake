class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    if order.status == "入金確認"
      order.order_details.update_all(making_status: "製作待ち")
    end
    redirect_to admin_order_path(order.id)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :status, :created_at)
  end
end
