# frozen_string_literal: true

class Api::OrdersController < ApplicationController
  def create
    product = Product.find(params['product_id'])
    order = current_user.orders.create
    order.order_items.create(product_id: product.id)
    # items = order.products
    if order.persisted?
      render json: {
        message: 'This pizza was added to your order!',
        order: {
          id: order.id,
          items: order.products
        }
      }, status: 201
    else
      render json: { message: 'Whoops, the developer fucked up here' }, status: 422
    end
  end
end
