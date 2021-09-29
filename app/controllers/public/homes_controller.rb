class Public::HomesController < ApplicationController

  def top
    @items = Item.page(params[:page]).per(4).reverse_order
    @genres = Genre.all
  end
end
