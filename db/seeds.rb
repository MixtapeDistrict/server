# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#THIS IS AN OLD SEEDS FILE, IT IS ONLY PARTIALLY COMPATIBLE WITH THE CURRENT SCHEMA, USE AT OWN RISK#

#Users#

User.create(username: "Stevenmagnet", password: "magnets", email: "steve@magnecorp.net", description: "Magnetic tape is the purest form of audio storage.", website_link: "http://gyropedia.wikia.com/wiki/Steven_Magnet", tracks_heard: "", image_path: 'steven.png')
User.create(username: "xX420Blazeit69Xx", password: "legaliseit", email: "swaglord69@yahoo.com", description: "I <3 bieber.", website_link: "http://goo.gl/MhC9G", tracks_heard: "", image_path: 'bropic.jpg')
User.create(username: "Obama", password: "POTUS", email: "potus@whitehouse.gov", description: "I prefer this site to spotify.", website_link: "http://www.whitehouse.gov/", tracks_heard: "", image_path: 'obama09.jpg')
User.create(username: "User1990", password: "BornIn1990", email: "username@isp.org", description: "User has not set a personalised description.", website_link: "http://www.google.com/", tracks_heard: "", image_path: 'user.jpg')

#Media#

Medium.create(user_id: 1, title: "Science is fun!", file_path: "/media/magnet1.mp3", image_path: "/media/images/magnet1.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 1, title: "The Courtesy Call", file_path: "/media/magnet2.mp3", image_path: "/media/images/magnet1.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 1, title: "You Will Be Perfect", file_path: "/media/magnet3.mp3", image_path: "/media/images/magnet1.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 1, title: "Almost at 50 Percent", file_path: "/media/magnet4.mp3", image_path: "/media/images/magnet1.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 1, title: "PotatOS Lament", file_path: "/media/magnet5.mp3", image_path: "/media/images/magnet1.jpg", downloads: 0, media_type: "music")

Medium.create(user_id: 2, title: "Will the Circle", file_path: "/media/swag1.mp3", image_path: "/media/images/1.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 2, title: "Beyond the Sea", file_path: "/media/swag2.mp3", image_path: "/media/images/2.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 2, title: "Everybody Wants to Rule the World", file_path: "/media/swag3.mp3", image_path: "/media/images/3.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 2, title: "Tainted Love", file_path: "/media/swag4.mp3", image_path: "/media/images/4.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 2, title: "Girls Just Want to Have Fun", file_path: "/media/swag5.mp3", image_path: "/media/images/5.jpg", downloads: 0, media_type: "music")

Medium.create(user_id: 3, title: "Meet the President", file_path: "/media/ob1.mp3", image_path: "/media/images/6.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 3, title: "This is How We Do It", file_path: "/media/ob2.mp3", image_path: "/media/images/7.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 3, title: "Hail to the Chief (Hiphop remix)", file_path: "/media/ob3.mp3", image_path: "/media/images/8.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 3, title: "Hail to the Chief Again", file_path: "/media/ob4.mp3", image_path: "/media/images/9.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 3, title: "I Don't Want to Set the World on Fire", file_path: "/media/ob5.mp3", image_path: "/media/images/10.jpg", downloads: 0, media_type: "music")

Medium.create(user_id: 4, title: "Kalimba", file_path: "/media/u1.mp3", image_path: "/media/images/11.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 4, title: "Maid with the Flaxen Hair", file_path: "/media/u2.mp3", image_path: "/media/images/12.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 4, title: "Sleep Away", file_path: "/media/u3.mp3", image_path: "/media/images/13.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 4, title: "Windows XP Sample #1", file_path: "/media/u4.mp3", image_path: "/media/images/14.jpg", downloads: 0, media_type: "music")
Medium.create(user_id: 4, title: "Windows XP Sample #2", file_path: "/media/u5.mp3", image_path: "/media/images/15.jpg", downloads: 0, media_type: "music")

#Albums#

Album.create(title: "Best of Magnets", imagepath: "/media/images/magnet1.jpg", description: "All sorts of electronic weirdness", downloads: 0)
Album.create(title: "Old Time Hits", imagepath: "/media/images/1.jpg", description: "Best of the past", downloads: 0)
Album.create(title: "Patriot", imagepath: "/media/images/6.jpg", description: "For the true patriot", downloads: 0)
Album.create(title: "Album Name", imagepath: "/media/images/11.jpg", description: "Put a description of your album here", downloads: 0)

#PlayLists#

Playlist.create(user_id: 1, title: "Magnet's Mix")
Playlist.create(user_id: 2, title: "B3st S0ngs 3var")
Playlist.create(user_id: 3, title: "Airforce 1 radio")
Playlist.create(user_id: 4, title: "Platlist Name")