## Phototag API

This is for [The Odin Project](https://www.theodinproject.com/).  This is an API that serves up images that come along with image maps that allow an application to know if an object/person in the image has been clicked. Each item in a photo has a rectangle defined by an upper left X,Y coordinate and a lower right X,Y coordianate.  This coordinates are based off 0,0 being the upper left of the image.  Each image can be associated with a challenge.  The challenge data has a meta_data field that can be used to customize your apps interaction with the image.  Each challenge has a leaderboard that records the names and times in which someone completed a challenge.

This projects focus was on developing the API so there is no user interface to generate API keys or create challenges or maintian the leaderboard.  There is no User table so the data structure was not designed around a User table, though it could easily be changed to accomadate a User table.  Each User would have a FK to the AccessToken table and have one to many Challenge relationship.

## The API works as follows:

Base URL: https://<i></i>tagphoto.herokuapp.com

Specifying an API KEY:

https://<i></i>tagphoto.herokuapp.com?APITOKEN=<32 character key>

The API will respond with a 400 HTTP code if the request was invalid in some way.  The JSON response will have more information in the error field that should show you how to correct your request.

The API will respond with a 404 HTTP code if no data matched the query.

## Requesting Photo data:

category: Requests all photos matching the specified category.
difficulty: Requests all photos matching the specified difficulty.
number: Limits number of photos requested.
image_filename: Requests data for a specific photo (Should be used by itself);

Example query:
https://<i></i>tagphoto.herokuapp.com/api/v1/photos?APITOKEN=<32 character key>?category=sci-fi&difficulty=easy

Sample API response:<br>
[{"name":"Five Star Trek Captains","desc":"Five Star Trek Captians","difficulty":"easy","category":"scifi","image_filename":"startrekcaptains.jpg","items":[{"name":"Sisko","top_left_loc":"138,3","bottom_right_loc":"238,146"},{"name":"Archer","top_left_loc":"252,1","bottom_right_loc":"346,142"},{"name":"Picard","top_left_loc":"363,1","bottom_right_loc":"463,142"},{"name":"Kirk","top_left_loc":"481,1","bottom_right_loc":"584,142"},{"name":"Janeway","top_left_loc":"611,3","bottom_right_loc":"739,134"}]}]

To retrieve an image:
https://<i></i>tagphoto.herokuapp.com/image_filename

## Requesting challenge data:

### To retrieve all your challenges:
https://<i></i>tagphoto.herokuapp.com/api/v1/challenges?APITOKEN=<32 character key>

Sample API response (It will return the associated leaderboard as well):<br>
[{"appid":"88cd371c98dded59","name":"Star Trek Captains timed challenge","desc":"Click on the face of each captain","photo_name":"startrekcaptains.jpg","meta_data":"{\"ctype\": \"timed\", \"ctime\": 30000, \"directed\": true}","leaderboards":[{"name":"JKL","challenge_time":7.0},{"name":"BVN","challenge_time":7.3},{"name":"AS","challenge_time":7.7},{"name":"GJH","challenge_time":7.8},{"name":"BNJ","challenge_time":8.2},{"name":"AS","challenge_time":8.4},{"name":"TI","challenge_time":9.1},{"name":"GJH","challenge_time":9.4},{"name":"GJH","challenge_time":15.6}]}]

### To retrieve leaderboard data for a challenge:
https://<i></i>tagphoto.herokuapp.com/api/v1/leaderboards?APITOKEN=<32 character key>&appid=<16 character appid>

Sample API response:<br>
[{"name":"JKL","challenge_time":7.0},{"name":"BVN","challenge_time":7.3},{"name":"AS","challenge_time":7.7},{"name":"GJH","challenge_time":7.8},{"name":"BNJ","challenge_time":8.2},{"name":"AS","challenge_time":8.4},{"name":"TI","challenge_time":9.1},{"name":"GJH","challenge_time":9.4},{"name":"GJH","challenge_time":15.6}]

## Posting to the leaderboard
Send a POST request with a payload in the JSON format: {leaderboard: {name: "name", challenge_time, "time"}} to:
https://<i></i>tagphoto.herokuapp.com/apiv1/leaderboards?APITOKEN=<32 character key>&appid=<16 character appid>

You will get a 201 HTTP response on a successful post.  Or a 400 if the request had an error, or 404 if there was no challenge with the specified appid.
