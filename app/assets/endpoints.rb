get ‘api/v1/post_emotions’

{ “data” : 
	[
	{ 
		“id”: 1 ,
	“type": “emotion”,
	"attributes": { "emotion": "contemplative",
									"definition": "expressing or involving prolonged thought"
								}
	},
	{ 
		“id”: 2 ,
	“type": “emotion”,
	"attributes": { "emotion": "forlorned",
									"definition": "pitifully sad and abandoned or lonely"
								}
	},
...
	]
}


get 'api/v1/friends?request_status=pending'
filter on pending
#headers pass in user

{ “data” : 
	[
	{ 
		“id”: 1 ,
	“type": "user",
	"attributes": { "name": "Melissa" }
	},
	{ 
		“id”: 2 ,
	“type": "user",
	"attributes": { "name": "Joseph" }
	},
	{ 
		“id”: 3 ,
	“type": "user",
	"attributes": { "name": "Josephine" }
	},
...
	]
}



get 'api/v1/friends?request_status=accepted'
# headers pass in user

{ “data” : 
	[
	{ 
		“id”: 1 ,
	“type": "friend",
	"attributes": { "name": "Melissa" }
	},
	{ 
		“id”: 2 ,
	“type": "friend",
	"attributes": { "name": "Peter" }
	},
	{ 
		“id”: 3 ,
	“type": "friend",
	"attributes": { "name": "Piper" }
	},
...
	]
}

get 'api/v1/history'
#this endpoint is to see your own history
#pass in user through headers
#this is refering to a specific users posts history

{ “data” : 
	[
		{ 
			“id”: 1 ,
		“type": "post",
		"attributes": {
				"emotion": "pensive"
				"post_status": "public"
				"description": "This was what I typed when I made this post."	 
				"created_at": "2022-11-01 17:02:19.036593 -0600"	 
			}
		},
		{ 
			“id”: 2 ,
		“type": "post",
		"attributes": {
				"emotion": "pensive"
				"post_status": "public"
				"description": "This was what I typed when I made this post."	 
				"created_at": "2022-11-01 17:02:19.036593 -0600"	 
			}
		},
		{ 
			“id”: 3 ,
		“type": "post",
		"attributes": {
				"emotion": "pensive"
				"post_status": "public"
				"description": "This was what I typed when I made this post."	 
				"created_at": "2022-11-01 17:02:19.036593 -0600"	 
			}	
		},
...
	]
}

get 'api/v1/friends'
#headers pass in user
#this is refering to a specific users friends

{ “data” : 
	[
		{ 
			“id”: “1” ,
		“type": "user",
		"attributes": {"name": "Quinland Russleford" }
		},
		{ 
			“id”: “2” ,
		“type": "user",
		"attributes": {"name": "Spider Man" }
		},
...
	]
}




get 'api/v1/friends/:friends_name/posts'
#headers pass in user
#this is refering to a specific users friend

{ “data” : 
	[
		{ 
			“id”: “1” ,
		“type": "post",
		"attributes": {
			"emotion": "joyful"
			"post_status": "public"
			"description": "This was what I typed when I made this post."	 
			"created_at": "2022-11-01 17:02:19.036593 -0600"	 
			}
		},
		{ 
			“id”: “2” ,
		“type": "post",
		"attributes": {
			"emotion": "pensive"
			"post_status": "public"
			"description": "This was what I typed when I made this post."	 
			"created_at": "2022-11-01 17:02:19.036593 -0600"	 
		}
	},
...
	]
}



get 'api/v1/users?search=<google_id>'

#want to search for a single user in the database using google id to identify the user
#return a single user (B) if user exists, and return a hash that looks like (A) if user doesn't exist

(A)
{ “data” : 
	{ }
}

(B)
{ “data” : 
	{ 
		“id”: “36” ,
	“type": "user",
	"attributes": {
		"name": "Jacob Methusula"	 
		"email": "jsnakes@gmail.com"	 
		"google_id": "fhsajbd912671284bf001028472jf"	 
		}
	}
}

post 'api/v1/users'
#pass in info through headers

{ 
	"status" : 201
}

