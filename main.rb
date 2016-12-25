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
def rotate_by_command(command)
l = command.split(" ")
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

def get_reverse_face(face)
    return (face[1] == "'")?face[0]:face[0] + "'"
    #return face[0] + "'" if face[1] == "" else face[0]
    end

def get_value_of_face(value)
    for k in @maps
        if k[1][0].index(value) != nil
        return k[0]
    end
    end
end

def get_corner_value(face,edge1,edge2)
    a = get(face,edge1)
    b = get(face,edge2)
    return (a&b)[0]
end

def get_value_state(value)
    face = get_value_of_face(value)
    res = []
    @maps[face][1].each_byte{|e|
        edge = e.chr
        if  get(face,edge).index(value) != nil
        i = @maps[face][1].index(edge)
        pre = (i - 1) >= 0?@maps[face][1][i - 1]:@maps[face][1][3]
        nex = (i+1) < 4?@maps[face][1][i+1]:@maps[face][1][3]
        if get(face,pre).index(value) != nil
            res.insert(0,pre+edge)
        else
            res.insert(0,edge+nex)
        end
        return [face,res[0]]
    end
    }
end

def get_stand_value(value,exclude_face)
    arr = get_value_state(value)
    another = arr[1].split("") - [exclude_face]
    return [another[0],get_corner_value(another[0],arr[0],exclude_face)]
end

def translate(face_as_F,command,is_reverse = false)
    up = (is_reverse==false)? U: D
    m = {face_as_F=>F,U=>up,D =>get_face_to_face(up)}
    # @maps[up][1].each_byte{|e|
    #     edge = e.chr
    #     edge.
    # }
    1.upto 3 do |i|
        beg = @maps[up][1].index(face_as_F)+i
        beg = beg > 3?beg - 4:beg
        ind = @maps[up][1].index(F)+i
        ind = ind > 3?ind - 4:ind
        m[@maps[up][1][beg]] = @maps[up][1][ind]
    end
    p m 
    true_command = []
    command.split(" ").each{|ele|
        insert = m[ele[0]] + ele[1].to_s
        insert = (is_reverse == true)?get_reverse_face(insert):insert
        true_command.insert(-1,insert)

    }
    p m
    return true_command.join(" ")
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
@init_command = "R' F' D' L' D L' F' B' L L'"
rotate_by_command @init_command
# # @maps[F][0].each{|num|
# # p get_color(num)
# # }
# get(L,F).each{|num|
# p get_color(num)
# #p num
# }
#p get_stand_value(11,F)
p translate R,"F D F'",true
#p @maps[D][0]
# @maps[D][1].each_byte{|e|
# edge = e.chr
# p edge
# }
#puts get_face(get(D,F)[0])