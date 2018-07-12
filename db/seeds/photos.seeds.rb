photo = Photo.create(name: "Five Star Trek Captains", desc: "Five Star Trek Captians", difficulty: "easy" , category: "scifi", image_filename: "startrekcaptains.jpg")
#<map name="image-map">
#    <area target="" alt="sisko" title="sisko" href="" coords="195,3,336,204" shape="rect">
#    <area target="" alt="archer" title="archer" href="" coords="354,0,487,196" shape="rect">
#    <area target="" alt="picard" title="picard" href="" coords="516,3,651,203" shape="rect">
#    <area target="" alt="kirk" title="kirk" href="" coords="679,2,822,198" shape="rect">
#    <area target="" alt="janeway" title="janeway" href="" coords="865,4,1044,191" shape="rect">
#</map>
photo.items.build(name: "Sisko", top_left_loc: "195,3", bottom_right_loc: "336,204").save
photo.items.build(name: "Archer", top_left_loc: "354,0", bottom_right_loc: "487, 196").save
photo.items.build(name: "Picard", top_left_loc: "516,3", bottom_right_loc: "516,203").save
photo.items.build(name: "Kirk", top_left_loc: "679,2", bottom_right_loc: "822,198").save
photo.items.build(name: "Janeway", top_left_loc: "865,4", bottom_right_loc: "1044,191").save
