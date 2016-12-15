def rotate(en3,point,v,a = Math::PI / 2)
ents = Sketchup.active_model.entities
tr = Geom::Transformation.rotation(point,v,a)
#ents.transform_entities tr, en3
#UI.start_timer(1, false) { ents.transform_entities tr, en3;en3.explode }

view = Sketchup.active_model.active_view
number_of_frames = 500
angle_change = a / number_of_frames.to_f
rotform = Geom::Transformation.rotation( point, v, angle_change )
number_of_frames.times do
  en3.move! rotform * en3.transformation
  view.refresh
end
en3.explode
end
#v represent which dirction to rotate while one is plus toward big than 0 face deside which face to rotate in the same axis
def rotate_more(v,face)
  ents = Sketchup.active_model.entities
  l = []
  #ents[0].bounds.center.to_a[1]
  #l.insert(-1,ents[0])
  limit = 0
  if face == 1
  limit = 5
  else
  limit = 2
  end
  index = 0
  #v.each{|single| if single != 0;index =i;i=i +1;end}
  while index < v.length
  	if v[index] != 0;break;end
  	index=index +1
  end
  ents.each{|g| 
    #roup=g.instances[0] if g.instances[0].name==name 
    if face == 1
    if g.bounds.center.to_a[index] > limit;l.insert(-1,g)
    end
    else
    if g.bounds.center.to_a[index] < limit;l.insert(-1,g)
    end
    end
  }
  
  group = ents.add_group l
  #l.each{|ent|group.entities.add_group ent}
  #group = find_group("yellow") 
  rotate(group,group.bounds.center,v)
end
def find_group(name)
model=Sketchup.active_model 
groups=[] 
model.definitions.each{|d| 
  groups << d if d.group? 
} 
group=nil 
groups.each{|g| 
  group=g.instances[0] if g.instances[0].name==name 
}
return group
end
l = [[0,0,1],[1,0,0]]
i = 0
while i < 2
rotate_more(l[i],-1)
i = i + 1
end



