class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
    @addresses = Address.where(customer_id: current_customer.id)
    cart_items = current_customer.cart_items
    if cart_items.empty?
      redirect_to cart_items_path
    end
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
      if params[:order][:address_option] == "1"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name+current_customer.first_name
      elsif params[:order][:address_option] == "2"
        @sta = params[:order][:address_id].to_i
        @order_address = Address.find(@sta)
        @order.postal_code = @order_address.postal_code
        @order.address = @order_address.address
        @order.name = @order_address.name
      else
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
      end
  end

  def complete
  end

  def create
    order = Order.new(order_params)
    order.shipping_cost = 800
    order.customer_id = current_customer.id
    if order.save
      cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.amount = cart_item.amount
        @order_detail.item_id = cart_item.item_id
        @order_detail.price = (cart_item.item.price*1.1).to_i
        @order_detail.order_id = order.id
        @order_detail.making_status = 0
        @order_detail.save
        cart_item.destroy
      end
    end
    redirect_to orders_complete_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @orders = current_customer.orders
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment,)
  end

end
