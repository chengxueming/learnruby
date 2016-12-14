#puts [1,2,3,4,5,6].reverse!
# l = [5,2,3]
# l.each{|a|puts a
# }
# if l[0] > 2;puts "hello";end
#puts[0:]
F = "F"
R = "R"
L = "L"
B = "B"
U = "U"
D = "D"
@maps = {F=>[[1,2,3,4,5,6,7,8,9],"URDL"],
        R=>[[21,22,23,24,25,26,27,28,29],"UBDF"],
        L=>[[31,32,33,34,35,36,37,38,39],"UFDB"],
        B=>[[41,42,43,44,45,46,47,48,49],"ULDR"],
        U=>[[51,52,53,54,55,56,57,58,59],"BRFL"],
        D=>[[61,62,63,64,65,66,67,68,69],"FRBL"],}


def set(face, bar,new)
    l = @maps[face]
    # face = "U"
    index = l[1].index(bar)
    if index == 0
        l[0][0,3] = new
    elsif index == 1
    	l[0][2] = new[0]
    	l[0][5] = new[1]
    	l[0][8] = new[2]
    elsif index == 2
        l[0][6,9] = new
    elsif index == 3
        l[0][2] = new[0]
    	l[0][5] = new[1]
    	l[0][8] = new[2]
end
end

def get(face,bar)
    l = @maps[face]
    #face = "U"
    index = l[1].index(bar)
    if index == 0
        return l[0][0...3]
    elsif index == 1
    	list = []
        l[0].each_slice(3){|ele|
        	list << ele[2]
        }
        return list
    elsif index == 2
        return l[0][6...9]
    elsif index == 3
       	list = []
        l[0].each_slice(3){|ele|
        	list << ele[0]
        }
        return list
    end
end

# def roate_other(face,m):
#     last = get(m[face][1][3],face)
#     for i in range(3,-1,-1):
#         if i ==  0:
#             #print(m[face][1][0]," ",m[face][1][3])
#             set(m[face][1][i],face,last)
#             break
#         set(m[face][1][i], face, get(m[face][1][i-1],face))
def roate_other(face,m)
    last = get(m[face][1][3],face)
    for i in (3...-1)
        if i ==  0
            #print(m[face][1][0]," ",m[face][1][3])
            set(m[face][1][i],face,last)
        else
        set(m[face][1][i], face, get(m[face][1][i-1],face))
    end
end
end
def roate_other_r(face,m)
    first = get(m[face][1][0], face)
    (0...4).each{|i|
        if i == 3
            set(m[face][1][i], face, first)
            #print(m[face][1][i],m[face][1][0])
 		else
        #print(m[face][1][i], m[face][1][i + 1])
        set(m[face][1][i], face, get(m[face][1][i+1], face))
    end
    }
end


   #  [0...3].each{|i|
   #      if i == 3
   #          puts @maps[F][0][i+1]
   #          #print(m[face][1][i],m[face][1][0])
 		# else
   #      #print(m[face][1][i], m[face][1][i + 1])
   #      puts @maps[F][0][i]
   #  end
   #  }
roate_other("F",@maps)
puts @maps