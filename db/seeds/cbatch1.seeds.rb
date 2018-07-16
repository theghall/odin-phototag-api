token = AccessToken.where(token: "9931c7c14267f95303df6518c28d8fd6").first
token.challenges.build(appid: "88cd371c98dded59", name: "Star Trek Captains timed challenge", desc:"Click on the face of each captain", photo_name: "startrekcaptains.jpg", meta_data: '{"ctype": "timed", "ctime": 30000, "directed": true}').save
