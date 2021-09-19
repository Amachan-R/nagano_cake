class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = Order_detail.find(params[:id])
    order_detail.update(order_detail_params)

  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :amount, :price, :making_status)
  end
end
