# frozen_string_literal: true

retailer_types = ['Wholesales', 'Clothes Distributer', 'Herbal Supplier', 'Food Supplier', 'Electronics Supplier']

retailer_types.each do |r|
  RetailerType.create(name: r)
end

15.times do
  Retailer.create(
    name: Faker::Appliance.brand,
    phone_no: Faker::PhoneNumber.cell_phone_with_country_code,
    address: Faker::Address.full_address,
    pan_number: Faker::Number.leading_zero_number(digits: 10),
    retailer_type_id: RetailerType.find_by(name: retailer_types.sample).id
  )
end

15.times do
  Product.create(
    name: Faker::Appliance.equipment,
    price: Faker::Number.between(from: 3000, to: 6000),
    description: Faker::Games::Dota.quote,
    qty: Faker::Number.between(from: 1, to: 100)
  )
end

15.times do
  phone_no = Faker::PhoneNumber.cell_phone_with_country_code
  gender = Faker::Gender.binary_type
  name = Faker::Name.name
  email = Faker::Internet.email
  user = User.create(email: email, password: 'password', name: name,
                     gender: gender, phone_no: phone_no, role: "customer")
  Customer.create(
    name: name,
    email: email,
    phone_no: phone_no,
    user_id: user.id,
    gender: gender,
    birthday: Faker::Date.between(from: '1980-09-23', to: '2000-09-25'),
    address: Faker::Address.full_address
  )
end
