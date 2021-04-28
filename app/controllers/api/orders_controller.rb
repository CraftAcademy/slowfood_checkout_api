# frozen_string_literal: true

class Api::OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params['product_id'])
    order = current_user.orders.create
    order.items.create(product: product)
    order_response(order, order, 201)
  end

  def update
    order = Order.find(params['id'])
    product = Product.find(params['product_id'])
    new_order_item = order.items.create(product: product)
    order_response(new_order_item, order, 200)
  end

  private

  def order_response(resource, order, status)
    if resource.persisted?
      render json: {
        message: 'This pizza was added to your order!',
        order: { id: order.id,
                 items: order.products }
      }, status: status
    else
      render json: { message: 'Whoops, something went wrong!' }, status: 422
    end
  end
end
