#puts [1,2,3,4,5,6].reverse!
# l = [5,2,3]
# l.each{|a|puts a
# }
# if l[0] > 2;puts "hello";end
#puts[0:]
  index = 0
  v = [1,0,0]
  #v.each{|single| if single != 0;index =i;i=i +1;end}
  while index < v.length
  	if v[index] != 0;break;end
  	index=index +1
  end
  puts index