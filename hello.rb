#require __FILE__.join("..\main.rb")
require File.join(__FILE__,"../main")

#获得中棱

#还原顶面
#遍历每一个面
=begin
for k in @maps
	#遍历一个面的每一条边
	k[1][1].each_byte{|e|
		#当前的面
		face = k[0]
		#当前的边
		edge = e.chr
		#当前的边数据
		l = get(face,edge)
		#puts k[0] + "," + e.chr + ":" + l[0]
		#puts l.to_s
		#侧边的数据
		stand = get(edge,face)
		#puts stand.to_s
		if get_face(l[0]) == U
			#边是符合的
			if face == U and get_face(stand[0]) == edge
				puts "good"
			end
		end


	}
end
=end
#判断一个面是否完成
def judge_1_floor(face)
@maps[face][0].each{|e|
	if get_face(e) != face
		return false
	end
}
@maps[face][1].each_byte{|e|
	#当前的边
	edge = e.chr
	#当前的边数据
	l = get(face,edge)
	#puts k[0] + "," + e.chr + ":" + l[0]
	#puts l.to_s
	#侧边的数据
	stand = get(edge,face)
	#puts stand.to_s
	stand.each{|e|
		if get_face(e) != edge
			return false
		end
	}
	return true
}
end
#判断一个十字是否完成
def judge_1_cross(face)
@maps[face][1].each_byte{|e|
	#当前的边
	edge = e.chr
	#当前的边数据
	l = get(face,edge)
	if get_face(l[1]) != face
		return false
	end
	#puts k[0] + "," + e.chr + ":" + l[0]
	#puts l.to_s
	#侧边的数据
	stand = get(edge,face)
	#puts stand.to_s
	if get_face(stand[1]) != edge
		return false
	end
}
return true
end
#判断某个面四个角是否完成
def judge_4_corner(face)
@maps[face][1].each_byte{|e|
	#当前的边
	edge = e.chr
	#当前的边数据
	l = get(face,edge)
	if get_face(l[0]) != face or get_face(l[2]) != face
		return false
	end
	#puts k[0] + "," + e.chr + ":" + l[0]
	#puts l.to_s
	#侧边的数据
	stand = get(edge,face)
	#puts stand.to_s
	if get_face(stand[0]) != edge or get_face(stand[2]) != edge
		return false
	end
}
return true
end
#判断中间面四个角是否完成
def judge_second_floor_4_corner(face)
@maps[face][1].each_byte{|e|
	#当前的边
	edge = e.chr
	get_left_and_right(face,edge).each{|ele|
		if get_face(get(edge,ele)[1]) != edge 
			return false
		end
	}
	}
return true
end



=begin
count = 1
while true do
	if judge_1_cross U
		if judge_4_corner U
			if judge_second_floor_4_corner U
			else
				#完成第二层的代码
			end
		else
			#完成第一个四个角的代码
		end
	else
		#完成十字架的代码
	end
end
=end

#还原十字
=begin
	
rescue Exception => e
	
end
def back_single_cross(face)
other = get_face_to_face(face)
@maps[other][1].each_byte{|e|
edge = e.chr
if get_face(get(other,edge)[0]) == face
	#目标旋转面
	destin = get_face(get(edge,other)[0])
	while get_face(get(destin,other)[0]) != destin
		rotate_by_command edge
	end
	rotate_by_command destin+destin,""
	return
end
}
end

def back_stand_cross(face)
other = get_face_to_face(face)
@maps[face][1].each_byte{|e|
	#当前的边
	edge = e.chr
	get_left_and_right(face,edge).each{|ele|
		if get_face(get(edge,ele)[1]) == face 
			if !get_is_clock(ele,edge,other)
				ele += "'"
			rotate_by_command ele
			return
		end
	}
	}
return true
end
=end
def back_son_cross(face)
	#判断底面有没有可以还原的
	p "D have"
	other = get_face_to_face(face)
	@maps[other][1].each_byte{|e|
	edge = e.chr
	if get_face(get(other,edge)[1]) == face
		#目标旋转面
		destin = get_face(get(edge,other)[1])
		p "edge=" + edge+" " +"other=" +other+" "  +"destin="+destin+" " 
		while get_face(get(destin,other)[1]) != destin
			rotate_by_command other
		end
		rotate_by_command [destin,destin].join(" ")
		return
	end
	}
	p "stand have"
	#判断每个侧棱有没有可以变成底面的
	@maps[face][1].each_byte{|e|
		#当前的边
		edge = e.chr
		puts "face =>" + face + "edge =>" + edge + "two face:" + get_left_and_right(face,edge).to_s
		get_left_and_right(face,edge).each{|ele|
			if get_face(get(edge,ele)[1]) == face 
				if !get_is_clock(ele,edge,other)
					ele += "'"
				end
				#p ele + other + get_reverse_face(ele),""
				rotate_by_command [ele,other,get_reverse_face(ele)].join(" ")
				return
			end
		}
	}
	p "top have"
	#判断每个顶面有没有可以变成底面的
	@maps[face][1].each_byte{|e|
	edge = e.chr
	if get_face(get(face,edge)[1]) == face and get_face(get(edge,face)[1]) != edge
		#目标旋转面
		rotate_by_command [edge,edge].join(" ")
		return
	end
	}
	p "up and down have"
	#判断每个上下侧面有没有可以变成侧棱的
	@maps[face][1].each_byte{|e|
	#当前的边
	edge = e.chr
	[face,other].each{|ele|
		value = get(edge,ele)[1]
		if get_face(get(edge,ele)[1]) == face 
		if ele == other
			cur = get_value_of_face value
			

		end
		rotate_by_command edge
		return
		end
	}
	}
	p "break"
end

def back_cross(face)
	count = 0
	until  judge_1_cross face do
		back_son_cross face
	count += 1
	if count > @max_step
		return
	end
	end
end
def back_mofang()
count = 1
while true do
	if judge_1_cross U
		if judge_4_corner U
			if judge_second_floor_4_corner U
			else
				#完成第二层的代码
			end
		else
			#完成第一个四个角的代码
		end
	else
		back_cross U #完成十字架的代码
	end
end
end

def back_four_corner_son(face)
	other = get_face_to_face(face)
	#对于底下的两个角
@maps[face][1].each_byte{|e|
#当前的边
edge = e.chr
puts "face =>" + face + "edge =>" + edge + "two face:" + get_left_and_right(face,edge).to_s
get_left_and_right(face,edge).each{|ele|
	corner_value = get_corner_value(edge,other,ele)
		if get_face(corner_value) == face 
			stands = get_stand_value(corner_value,other)
			
			while get_face(stands[1]) != stands[0] do
				rotate_by_command other
				stands = get_stand_value(corner_value,other)
			end
			p stands
			cur = get_value_of_face(corner_value)
			if get_face_edge_info(face,stands[0],cur)
				command = translate cur, "F D F'"
				rotate_by_command command
			else
				command = translate stands[0], "R' D' R"
				rotate_by_command command
			end
			return
		end
	}
}
	#判断顶层的stand面有没有face的
@maps[face][1].each_byte{|e|
#当前的边
edge = e.chr
puts "face =>" + face + "edge =>" + edge + "two face:" + get_left_and_right(face,edge).to_s
get_left_and_right(face,edge).each{|ele|
		corner_value = get_corner_value(edge,face,ele)
		
		if get_face(corner_value) == face
			p "stand and up #{edge},#{ele}"
			dest = edge
			if !get_is_clock(edge,ele,other)
				dest += "'"
			end
			rotate_by_command dest
			 another = escape_edge(corner_value,other,dest[0])
			p ":haha:#{dest},#{another},#{get_reverse_face(dest)}"
			rotate_by_command [other,get_reverse_face(dest)].join(" ")
			return
		end
	}
}
#判断顶层的顶面有没有face的
@maps[face][1].each_byte{|e|
#当前的边
edge = e.chr
puts "face =>" + face + "edge =>" + edge + "two face:" + get_left_and_right(face,edge).to_s
get_left_and_right(face,edge).each{|ele|
		
		corner_value = get_corner_value(face,edge,ele)
		if get_face(corner_value) == face and !(get_face(get_stand_value(corner_value,edge)) == ele and get_face(get_stand_value(corner_value,ele)) == edge)
			if !get_is_clock(ele,face,edge)
				ele += "'"
			end
			rotate_by_command [ele,other,get_reverse_face(ele)].join(" ")
			return
		end
	}
}
#判断底层的底面有没有face的
@maps[face][1].each_byte{|e|
#当前的边
edge = e.chr
puts "face =>" + face + "edge =>" + edge + "two face:" + get_left_and_right(face,edge).to_s
	get_left_and_right(face,edge).each{|ele|
		
		corner_value = get_corner_value(other,edge,ele)
		if get_face(corner_value) == face
			while get_face(get_otehr_face_value(corner_value)) == face do
				rotate_by_command other
			end
			des = get_value_state(corner_value)[1]
			dirct = des[0]
			if !get_is_clock(des[0],des[1],other)
				dirct += "'"
			end
			rotate_by_command [dirct,other,get_reverse_face(dirct)].join(" ")
		end
	}
}
end

def back_four_corner(face)
	count = 0
	until  judge_4_corner face do
		back_four_corner_son face
	count += 1
	if count > @max_step
		return
	end
	end
end


back_four_corner(U)
puts @command[@init_command.length..@command.length]
