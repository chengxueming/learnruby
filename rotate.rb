ents = Sketchup.active_model.entities
en3 = Sketchup.active_model.entities.add_group ents[0],ents[1]
v = Geom::Vector3d.new 0,0,1
a = Math::PI / 4
tr = Geom::Transformation.rotation(en3.bounds.center,v,a)
ents.transform_entities tr, en3
view = Sketchup.active_model.active_view
id = UI.start_timer(2, false) { ents.transform_entities tr, en3 }
#UI.stop_timer(id)
#ents.transform_entities tr, en3

