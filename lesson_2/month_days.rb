=begin
Сделать хеш, содеращий месяцы и количество дней в месяце. В цикле выводить те месяцы, у которых количество дней ровно 30
=end

monts_days = {
  'January' => 31,
  'February' => 28,
  'March' => 31,
  'April' => 30,
  'May' => 31, 
  'June' => 30,
  'July' => 31,
  'August' => 31,
  'September'=> 30,
  'October' => 31,
  'November' => 30,
  'December' => 31
}

monts_days.each { |key, value| puts key if value == 30 } 
