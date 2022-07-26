class Admin::OrderDetailsController < ApplicationController
  def update
    #@order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order
    @order_details = @order.order_details

     if @order_detail.making_status == "making"
       @order.update(status: "making")
     end


     if not @order_details.where.not(making_status: "finish").exists?
       @order.update(status: "ready")
     end

    redirect_to admin_order_path(@order.id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
