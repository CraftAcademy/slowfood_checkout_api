# frozen_string_literal: true

class Api::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :order_confirmed?, only: [:update]

  def create
    product = Product.find(params['product_id'])
    order = current_user.orders.create
    order.items.create(product: product)
    order_response(order, order, 201)
  end

  def update
    if params['confirmed']
      confirm_order(@order)
    else
      product = Product.find(params['product_id'])
      new_order_item = @order.items.create(product: product)
      order_response(new_order_item, @order, 200)
    end
  end

  private

  def confirm_order(order)
    order.update(confirmed: true)
    render json: { message:
        'Your order is confirmed and will be ready to pick up in 15 min to a quarter' }
  end

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

  def order_confirmed?
    @order = Order.find(params['id'])
    return unless @order.confirmed?

    render json: { message:
      'This order has already been confirmed, to order more food, create a new order' },
           status: 403
  end
end
