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
        R=>[[11,12,13,14,15,16,17,18,19],"UBDF"],
        L=>[[21,22,23,24,25,26,27,28,29],"UFDB"],
        B=>[[31,32,33,34,35,36,37,38,39],"ULDR"],
        U=>[[41,42,43,44,45,46,47,48,49],"BRFL"],
        D=>[[51,52,53,54,55,56,57,58,59],"FRBL"],}


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
        l[0][6,9] = new.reverse
    elsif index == 3
        l[0][6] = new[0]
        l[0][3] = new[1]
        l[0][0] = new[2]
end
end

#默认都是顺时针获得
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
        return l[0][6...9].reverse
    elsif index == 3
        list = []
        l[0].each_slice(3){|ele|
            list << ele[0]
        }
        return list.reverse
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
ROW = 3
COL = 3
def rotate(a)
    for row in (0...ROW)
        for col in (row...ROW)
            a[row*COL + col],a[col*COL + row] = a[col*COL + row],a[row*COL + col]
        end
    end
    a.reverse!
    a[0...3],a[6...9] = a[6...9],a[0...3]
end
def rotate_r(a)
    for row in (0...ROW)
        for col in (row...ROW)
            a[row*COL + col],a[col*COL + row] = a[col*COL + row],a[row*COL + col]
        end
    end
    a[0...3],a[6...9] = a[6...9],a[0...3]
end

def roate_other(face,m)
    last = get(m[face][1][3],face)
    3.downto 0 do |i|
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

def rotate_face(m,face,clock = true)
    if clock
        rotate(m[face][0])
        roate_other(face,m)
    else
        rotate_r(m[face][0])
        roate_other_r(face,m)
    end
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
@command = ""
def rotate_by_command(command,type = " ")
l = command.split(type)
l.each{|b|
    clock = true
    clock = false if b[1] == "'"
    #puts b[0]+" "+clock.to_s
    rotate_face(@maps,b[0],clock)
}
p l
@command += " " if @command.length != 0
@command += l.join(" ")
end

def get_color(num)
    colors = ["yellow","blue","red","green","white","orange"]
    return colors[num/10]
end

def get_face(num)
    face = ["F","R","L","B","U","D"]
    return face[num/10]
end

def get_face_to_face(face)
    m = ["F","R","L","B","U","D"]
    him = @maps[face][1].split("") + [face]
    r = m - him
    return r[0]
end

def get_left_and_right(face,edge)
    m = @maps[edge][1].split("") - [face] - [get_face_to_face(face)]
    return m
end

def get_is_clock(face,from,to)
    return @maps[face][1].index(to) > @maps[face][1].index(from)
end
# rotate_face(@maps,F,true)
#set(F,U,[111,222,333])
#roate_other(F,@maps)
#puts get(R,F)
#set(R, F, get(U,F))
# for i in get(U,F)
# puts colors[i/10]
# end
#puts get(U,F)
rotate_by_command "D' B' F' D L'"
# # @maps[F][0].each{|num|
# # p get_color(num)
# # }
# get(D,F).each{|num|
# p get_color(num)
# #p num
# }
#p @maps[D][0]

# @maps[D][1].each_byte{|e|
# edge = e.chr
# p edge
# }
#puts get_face(get(D,F)[0])