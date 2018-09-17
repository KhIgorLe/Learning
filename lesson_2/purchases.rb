=begin
Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара
(может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор,
пока не введет "стоп" в качестве названия товара.
На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

products = {}
puts "Введите название товара"
name_product = gets.chomp
while name_product != "стоп" do
  puts "Введите цену за еденицу товара"
  cost = gets.to_f

  puts "Введите количество купленного товара"
  quantity = gets.to_f

  products[name_product] = { cost: cost, quantity: quantity }

  puts "Введите название товара"
  name_product = gets.chomp
end

puts products

total_cost_basket = 0

products.each do | product, cost_quantity |
  total_amount_product = cost_quantity[:cost] * cost_quantity[:quantity]
  total_cost_basket += total_amount_product
  puts "Итоговая сумма за #{product} = #{total_amount_product}"
end

puts "Итоговая сумму всех покупок = #{total_cost_basket}"
