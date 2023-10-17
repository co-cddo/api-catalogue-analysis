class ItemsController < ApplicationController
  def index
    @items = Item.order(number_required: :desc)
  end

  def show
    @item = Item.find(params[:id])
    @metadata_mapper = MetadataMapper.new(@item)
  end
end
