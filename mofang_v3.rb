def rotate(en3,point,v,a)
ents = Sketchup.active_model.entities
tr = Geom::Transformation.rotation(point,v,a)
ents.transform_entities tr, en3
UI.start_timer(2, false) { ents.transform_entities tr, en3 }
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


group = find_group("yellow") 
rotate(group,group.bounds.center,[0,1,0],Math::PI / 4)

