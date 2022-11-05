# How are you doing? ((Backend))

## Table of contents

- [Schema](#Schema)
- [Endpoints](#endpoints)
- [Contributors](#contributors)

## Schema: 

<img src="./app/assets/images/schema.png" alt="The schema of the project includes 4 tables."  width="600" height="350" />


## Setup

- `Ruby 2.7.4`
- `Rails 5.2.8.1'`
- [Fork this repository](https://github.com/Alaina-Noel/How_Are_You_Doing_BE)
- Clone your fork
- From the command line, install gems and set up your DB:
- `bundle install`
- `rails db:create`
- `rails db:migrate`

# Endpoints

## Emotions
## Get all emotions for a post
get 'api/v1/emotions'

 ``` 
 {
    "data": [
        {
            "id": "1",
            "type": "emotion",
            "attributes": {
                "emotion": "Affectionate",
                "definition": "(of a person) Having affection or warm regard; loving; fond."
            }
        },
        {
            "id": "2",
            "type": "emotion",
            "attributes": {
                "emotion": "Confident",
                "definition": "A person in whom one can confide or share one's secrets: a friend."
            }
        },
        {
            "id": "3",
            "type": "emotion",
            "attributes": {
                "emotion": "Grateful",
                "definition": "Appreciative; thankful."
            }
        }
      ]
  }
  ``` 


## Users

## Get a specific user based on their google id
get 'api/v1/users?search=<google_id>'
```
{
    "data": {
        "id": "6",
        "type": "user",
        "attributes": {
            "name": "Hisoka Morow",
            "email": "hisoka.morow@meteorcity.gov",
            "google_id": "91239464"
        }
    }
}
```
## returns this if no user is found with that google id

```
{
    "data": []
}
```

## Search for a user using their email address
get '/api/v1/users?by_email=#{email}'
or
get '/api/v2/users?email=<email>'


```{
    "data": {
        "id": "5",
        "type": "user",
        "attributes": {
            "name": "Gon Freecss"
        }
    }
}
```
## returns this if no user is found with that email address

```
{
    "data": []
}
```

## returns a user when searching with both name and google_id
get '/api/v2/users?name=<name>&email=<email>&google_id=<google_id>'

```{
    "data": {
        "id": "5",
        "type": "user",
        "attributes": {
            "name": "Gon Freecss"
        }
    }
}
```
## returns this if no user is found with that email address

```
{
    "data": []
}
```


## Post or Create a new user to the backend database
post 'api/v1/users'

pass in name, google_id, and email in headers

```
{
    "message": "User successfully created"
}
```



## Posts [And by Posts we mean posts that a user makes on their dashboard]
## Get all posts of a user (history)

get '/api/v1/users/history' & pass in user through headers
or
get '/api/v2/users/history?user=<google_id>'

 ``` 
{ “data” : 
	[
		{ 
			“id”: 1 ,
		“type": "post",
		"attributes": {
				"emotion": "pensive"
				"post_status": "public"
				"description": "This was what I typed when I made this post."	 
				"tone" : "anger"
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
				"tone" : "anger"
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
				"tone" : "anger"
				"created_at": "2022-11-01 17:02:19.036593 -0600"	 
			}	
		}
	]
}
  ``` 

## Get the last post of a user (recent post)

get 'api/v2/users/last?user=<google_id>'

 ``` 
{ “data” : 
		{ 
			“id”: 3 ,
		“type": "post",
		"attributes": {
				"emotion": "pensive"
				"post_status": "public"
				"description": "This was what I typed when I made this post."	 
				"tone" : "anger"
				"created_at": "2022-11-01 17:02:19.036593 -0600"	 
			}	
		}
}
  ``` 



## create a new post
post '/api/v2/posts?user=<google_id>&emotion=<emotion_term>&description=<description>&post_status=<personal or shared>'

# if the post was successfully created
```
{
  “data” : 
  {
    “id”: 808 ,
   “type": "post",
   "attributes": {
     "emotion": "thrilled",
     "post_status": "personal",
     "description": "Today I got a job offer for the company that I really loved, and have admired for a long time.",
     "tone": "joy",
     "created_at": "2022-11-05T23:05:26.971Z"
    }
  }
}
```
# if the post was not successfully created
```
{
    "data": []
}
```
## update an existing post
patch '/api/v2/posts?user=<google_id>&emotion=<emotion_term>&description=<description>&post_status=<personal or shared>'






## Get all posts of a particular friend of a user
get '/api/v1/friends/<google_id>/posts'

<img src="./app/assets/images/friends_posts_endpoint.jpg" />





## Friends

## Get all friends of a user with a status of pending
get 'api/v1/friends?request_status=pending'
or
get '/api/v2/friends?request_status=<status>&user=<google_id>'


 ``` 
{
    "data": [
        {
            "id": "5",
            "type": "user",
            "attributes": {
                "name": "Gon Freecss",
                "email": "gon@hunterassociation.com"
            }
        },
        {
            "id": "6",
            "type": "user",
            "attributes": {
                "name": "Hisoka Morow",
                "email": "hisoka.morow@meteorcity.gov"
            }
        }
    ]
}
  ``` 

# returns the following if the user doesn't have any pending friend requests
  ``` 
  {
    "data": []
}
  ``` 


## Get all friends of a user with a status of accepted
get 'api/v1/friends?request_status=accepted'
or 
get '/api/v2/friends?request_status=<status>&user=<google_id>'


 ``` 
{
    "data": [
        {
            "id": "10",
            "type": "user",
            "attributes": {
                "name": "Andrew Mullins",
                "email": "gon@mullins.com"
            }
        },
        {
            "id": "13",
            "type": "user",
            "attributes": {
                "name": "Sable",
                "email": "Sable@doggo.gov"
            }
        }
    ]
}
  ``` 
# returns the following if the user doesn't have any accepted friend requests
  ``` 
  {
    "data": []
}
  ``` 



## Get all friends of a user regardless of acceptance/rejected/pending status
get 'api/v1/friends'
or
get '/api/v2/friends?user=<google_id>'

 ``` 
{
    "data": [
        {
            "id": "10",
            "type": "user",
            "attributes": {
                "name": "Andrew Mullins",
                "email": "gon@mullins.com"
            }
        },
        {
            "id": "13",
            "type": "user",
            "attributes": {
                "name": "Sable",
                "email": "Sable@doggo.gov"
            }
        }
    ]
}
  ``` 
# returns the following if the user doesn't have any friends regardless of status
  ``` 
  {
    "data": []
}
  ``` 


## Other endpoints to be updated later


Friends:
get '/api/v2/friends?email=<email>&user=<google_id>'
get '/api/v2/friends/:friendship_id?request_status=<status>'





## Contributors
-   **Andrew Mullins** -  - [GitHub Profile](https://github.com/mullinsand) - [LinkedIn](https://www.linkedin.com/in/andrewmullins233)
-   **Mary Ballantyne** -  - [GitHub Profile](https://github.com/mballantyne3) - [LinkedIn](https://www.linkedin.com/in/mary-ballantyne-2712241b2)
-   **Aleisha Mork** -  - [GitHub Profile](https://github.com/aleish-m) - [LinkedIn](https://www.linkedin.com/in/aleisha-mork/) 
-   **Carter Ball** -  - [GitHub Profile](https://github.com/cballrun) - [LinkedIn](https://www.linkedin.com/in/carter-ball-01b669160/)
-   **Alaina Kneiling** -  - [GitHub Profile](https://github.com/alaina-noel) - [LinkedIn](https://www.linkedin.com/in/alaina-noel/)

