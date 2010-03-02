require '../gmp/ext/gmp'

def reverse(p)
  GMP::Z(p.to_s.reverse)
end

puts "Using GMP version "+GMP::GMP_VERSION
puts ""

p = 11
finish = 100
while ARGV[0] =~ /^-/
  case ARGV[0]
  when '-f' then finish = ARGV[1].to_i; ARGV.shift; ARGV.shift
  when '-s' then p      = ARGV[1].to_i; ARGV.shift; ARGV.shift
  else ARGV.shift
  end
end

p = GMP::Z(p-2)

while p < finish
  p += 2
  if p % 128 == 1
    puts "#{p}..."
  end

  probab_prime = p.probab_prime?
  next if probab_prime == 0

  if probab_prime == 1
    puts "#{p} might be prime..."
  end

  q = reverse(p)

  probab_prime_q = q.probab_prime?
  next if probab_prime_q == 0

  if probab_prime_q == 1
    puts "#{q} might be prime..."
  end

  next if p % 10 < q % 10

  next if p == q

  s = "#{p} and #{q}... "
  print '.'
  pfacp1 = GMP::Z.fac(p) + 1
  qfacp1 = GMP::Z.fac(q) + 1
  probab_prime3 = pfacp1.probab_prime?
  case probab_prime3
  when 0
    next
  when 1
    s << "probably and "
  when 2
    s << "yes! and "
  end

  probab_prime4 = qfacp1.probab_prime?
  case probab_prime4
  when 0
    next
  when 1
    s << "probably"
  when 2
    s << "yes!"
  end
  puts s

end
