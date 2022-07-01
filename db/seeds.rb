# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Seeding Database..."

@user = User.create(
    email: "sebastianrcnt@gmail.com",
    name: "Sebastian Jeong",
    password_digest: "none"
)

@product = Product.create(
    name: "제주도 항공권 2매",
    price: 12500,
    owner: @user,
    call_to_action: "탑승하러 가기"
)

puts "Seeding Complete!"