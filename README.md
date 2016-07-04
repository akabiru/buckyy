[![Build Status](https://travis-ci.org/andela-akabiru/buckyy.svg?branch=master)](https://travis-ci.org/andela-akabiru/buckyy) [![Coverage Status](https://coveralls.io/repos/github/andela-akabiru/bucket-list-api/badge.svg?branch=master)](https://coveralls.io/github/andela-akabiru/bucket-list-api?branch=master) [![Code Climate](https://codeclimate.com/github/andela-akabiru/bucket-list-api/badges/gpa.svg)](https://codeclimate.com/github/andela-akabiru/bucket-list-api)


# Buckyy :roller_coaster: :sailboat:

Buckyy is a simple bucketlist API allowing consumers to perform CRUD operations on bucketlists. A user can have many bucketlists and each bucketlist
can have many items.

* [Getting Started](#getting-started)
* [Dependencies](#dependencies)
* [Tests](#tests)
* [API Endpoints](#api-endpoints)
* [Responses](#responses)
* [Error handling](#error-handling)
* [Versions](#versions)
* [Request & Response Examples](#request--response-examples)
* [Contributing](#contributing)

## API Features

  1. User authentication with [JWT](http://jwt.io).
  2. User can perform CRUD operations on Buckelist and items resources
  3. API accepts paginated requests with limit e.g. `curl -i http://buckyy.herokuapp.com/bucketlists?limit=5&page=2`
  4. API  uses Accept header to version api calls e.g. `Accept:application/vnd.buckyy.v1+json`.
  5. Apiary documentation for easier integration

## Getting Started

  1. `git clone https://github.com/andela-akabiru/buckyy.git`
  2. `cd buckyy`
  3. `bundle install`
  4. `rake db:setup`
  5. `rails serve`

The above will get you a copy of the project up and running on your local machine for development and testing purposes.

### Dependencies

  1. [Ruby](https://github.com/rbenv/rbenv)
  2. [PostgreSQL](http://www.postgresql.org/download/macosx/)
  3. [Bundler](http://bundler.io/)
  4. [Ruby on Rails](http://guides.rubyonrails.org/getting_started.html#installing-rails)
  5. [RSpec](http://rspec.info/)

## Tests
    1. cd buckyy
    2. bundle exec rake

## API Endpoints

All endpoints except `/signup` require a token for authentication. The API call should have the token in Authorization header.

    http http://buckyy.herokuapp.com/bucketlists \
    Authorization: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njc2MTkxNDV9.R6VLZD4qtsdVHXZwU8bEo6S16cbNQfo7lICsNdAq00I"

| EndPoint                                |   Functionality                      |
| --------------------------------------- | ------------------------------------:|
| POST /signup                            | Signup a user                        |
| POST /auth/login                        | Login user                           |
| GET /auth/logout                        | Logout a user                        |
| POST /bucketlists/                      | Create a new bucket list             |
| GET /bucketlists/                       | List all the created bucket lists    |
| GET /bucketlists/:id                    | Get single bucket list               |
| PUT /bucketlists/:id                    | Update this bucketlist               |
| DELETE /bucketlists/:id                 | Delete this single bucketlist        |
| POST /bucketlists/:id/items/            | Create a new item in bucketlist      |
| PUT /bucketlists/:id/items/:item_id     | Update a bucketlist item             |
| DELETE /bucketlists/:id/items/:item_id  | Delete an item in a bucket lists     |


## Responses

The API responds with JSON data by default.

## Error Handling

The API responds with an error message and http status code whenenever it encounters an error.

    {
      "error": "Not Found",
      "status": "404"
    }


## Versions

The API uses Accept header to version api calls e.g. `Accept:application/vnd.buckyy.v1+json`.
No breaking changes. :smiley:

## Request & Response examples

Request GET /bucketlists

     http https://buckyy.herokuapp.com/bucketlists \
     Authorization: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE0Njc2MTkxNDV9.R6VLZD4qtsdVHXZwU8bEo6S16cbNQfo7lICsNdAq00I'

Response (application/json)

    [
        {
            "created_by": "1",
            "id": 3,
            "items": [
                {
                    "bucketlist_id": 3,
                    "created_at": "2016-06-30T12:57:51.611Z",
                    "done": false,
                    "id": 3,
                    "name": "Obi-Wan Kenobi",
                    "updated_at": "2016-06-30T12:57:51.611Z"
                }
            ],
            "name": "eaque"
        },
        {
            "created_by": "1",
            "id": 4,
            "items": [
                {
                    "bucketlist_id": 4,
                    "created_at": "2016-06-30T12:57:51.613Z",
                    "done": false,
                    "id": 4,
                    "name": "Chewbacca",
                    "updated_at": "2016-06-30T12:57:51.613Z"
                }
            ],
            "name": "non"
        }
    ]

## Application Limitations

  1. The API only responds with JSON

## Contributing

1. Fork it! :fork_and_knife:
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git add -A && git commit -m 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature` :rocket:
5. Submit a pull request :sunglasses:

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://opensource.org/licenses/MIT) file for details
