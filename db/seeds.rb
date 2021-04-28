# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   Character.create(name: 'Luke', movie: movies.first)
Product.create([{ name: 'Vesuvio', ingredients: 'Ham, cheese', price: 68 },
                { name: 'Funghi', ingredients: 'Mushroom, cheese', price: 68 },
                { name: 'Kebab Pizza', ingredients: 'Kebab, cheese, lots of sauce!', price: 75 }])
