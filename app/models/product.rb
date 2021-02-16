# frozen_string_literal: true

class Product < ApplicationRecord
  validates_presence_of :name, :ingredients, :price
  validates :price, presence: true, numericality: { only_integer: true }
end
