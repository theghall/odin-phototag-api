photo = Photo.create(name: "Star Wars Characters", desc: "Star Wars characters", difficulty: "easy" , category: "scifi", image_filename: "starwars.jpg")
#<map name="image-map">
#    <area target="" alt="Rey" title="Rey" href="" coords="68,32,176,215" shape="rect">
#    <area target="" alt="Finn" title="Finn" href="" coords="300,291,369,401" shape="rect">
#    <area target="" alt="Leia" title="Leia" href="" coords="398,251,478,390" shape="rect">
#    <area target="" alt="Poe" title="Poe" href="" coords="513,279,581,390" shape="rect">
#    <area target="" alt="Kylo Ren" title="Kylo Ren" href="" coords="672,22,795,193" shape="rect">
#</map>
photo.items.build(name: "Rey", top_left_loc: "68,32", bottom_right_loc: "176,215").save
photo.items.build(name: "Finn", top_left_loc: "300,291", bottom_right_loc: "369,401").save
photo.items.build(name: "Leia", top_left_loc: "398,251", bottom_right_loc: "478,390").save
photo.items.build(name: "Poe", top_left_loc: "513,279", bottom_right_loc: "581,390").save
photo.items.build(name: "Kylo Ren", top_left_loc: "672,22", bottom_right_loc: "795,193").save
