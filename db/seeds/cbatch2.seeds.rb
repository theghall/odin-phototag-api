token = AccessToken.where(token: "9931c7c14267f95303df6518c28d8fd6").first
token.challenges.build(appid: "02599e04dd5e93aa", name: "Star Wars untimed challenge", desc:"Click on the face of each character", photo_name: "starwars.jpg", meta_data: '{"ctype": "untimed", "ctime": 0, "directed": false}').save
