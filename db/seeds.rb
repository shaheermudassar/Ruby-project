# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create(first_name: 'admin', last_name: 'adm', phone: 123_456, email: 'admin@gmail.com',
                    password: 'admin123', role: :admin, confirmed_at: DateTime.now)
admin.skip_confirmation!
moderator = User.create(first_name: 'moderator', last_name: 'mode', phone: 123_456, email: 'moderator@gmail.com',
                        password: 'mod123', role: :moderator, confirmed_at: DateTime.now)
moderator.skip_confirmation!
