require 'pry'

def ackerman(m, n)
  if m == 0
    return n + 1
  elsif m > 0 && n == 0
    return ackerman(m - 1, 1)
  elsif m > 0 && n > 0
    return ackerman(m - 1, ackerman(m, n - 1))
  else
  puts "Error"
  end
end

binding.pry