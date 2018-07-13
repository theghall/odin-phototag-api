photo = Photo.create(name: "Five Star Trek Captains", desc: "Five Star Trek Captians", difficulty: "easy" , category: "scifi", image_filename: "startrekcaptains.jpg")
#<map name="image-map">
#    <area target="" alt="Sisko" title="Sisko" href="" coords="138,3,238,146" shape="rect">
#    <area target="" alt="Archer" title="Archer" href="" coords="252,1,346,142" shape="rect">
#    <area target="" alt="Picard" title="Picard" href="" coords="363,1,463,142" shape="rect">
#    <area target="" alt="Kirk" title="Kirk" href="" coords="481,1,584,142" shape="rect">
#    <area target="" alt="Janeway" title="Janeway" href="" coords="611,3,739,134" shape="rect">
#</map>
photo.items.build(name: "Sisko", top_left_loc: "138,3", bottom_right_loc: "238,146").save
photo.items.build(name: "Archer", top_left_loc: "252,1", bottom_right_loc: "346,142").save
photo.items.build(name: "Picard", top_left_loc: "363,1", bottom_right_loc: "463,142").save
photo.items.build(name: "Kirk", top_left_loc: "481,1", bottom_right_loc: "584,142").save
photo.items.build(name: "Janeway", top_left_loc: "611,3", bottom_right_loc: "739,134").save
