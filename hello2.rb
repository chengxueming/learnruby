# def get_face_to_face(face)
#     m = ["F","R","L","B","U","D"]
#     him = "LRDU".split("") + [face]
#     r = m - him
#     return r[0]
# end
# p get_face_to_face "F"
# if !false
# 	puts "heh"
# end
# a = 1
# b = 2
# a,b = b,a
# p a.to_s + b.to_s
#p "BRFL"[3,]+"BRFL"[0...3]
# 0.upto 4 do |i|
#     p i 
# end
# a = {"a" => "abc"}
# s = String.new(a["a"])
# s[0],s[2] = s[2],s[0]
# p "#{s},#{a}"
# a = "abc"
# t = false
# a = "123" if t == true
# p a
m = {"a" =>1,"b" =>2}
m["a"],m["b"] = m["b"],m["a"]
p m