class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(8).reverse_order
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :image)
  end
end
