# frozen_string_literal: true

class Api::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product

  def create
    order = current_user.orders.create
    order.order_items.create(product_id: @product.id)
    order_response(order, order, 201)
  end

  def update
    order = Order.find(params['id'])
    new_item = order.order_items.create(product_id: @product.id)
    order_response(new_item, order, status)
  end

  private

  def find_product
    @product = Product.find(params['product_id'])
  end

  def order_response(resource, order, status)
    if resource.persisted?
      render json: {
        message: 'This pizza was added to your order!',
        order: {
          id: order.id,
          items: order.products
        }
      }, status: status
    else
      render json: { message: 'Whoops, the developer fucked up here' }, status: 422
    end
  end
end
