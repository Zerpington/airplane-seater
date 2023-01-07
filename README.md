# airplane-seater V1.1
### Introduction
A work exam application done with love and a bottomless coffee cup. A Junior Dev with the willingness to learn.


## How the Application Works
Send a `POST` request with params (seats, passengers) as such to `/api/plan_seat/`. `[server]` is usually `localhost:3000`.
```
[server]/api/plan_seat/?seats=[[3,2], [4,3], [2,3], [3,4]]&passengers=30
```
which will return
```
{
    "plane_layout": [
        [
            [["W", 19], ["M", 25], ["A", 1]], 
            [["W", 21], ["M", 29], ["A", 7]]
        ],
        [
            [["A", 2], ["M", 26], ["M", 27], ["A", 3]], 
            [["A", 8], ["M", 30], ["M", nil], ["A", 9]], 
            [["A", 13], ["M", nil], ["M", nil], ["A", 14]]
        ],
        [
            [["A", 4], ["A", 5]],
            [["A", 10], ["A", 11]],
            [["A", 15], ["A", 16]]
        ],
        [
            [["A", 6], ["M", 28], ["W", 20]], 
            [["A", 12], ["M", nil], ["W", 22]], 
            [["A", 17], ["M", nil], ["W", 23]], 
            [["A", 18], ["M", nil], ["W", 24]]
        ]
    ]
}
```
* I also made a simple front view at the url root of the app which you can use to get the json output which can usually be found at `localhost:3000` after running the server

## Installation

### Install the app after cloning the repository
```
cd airplane-seater
bundle install
```
### Then run the server
```
rails s
```

## Unit Test
RSpec gem is used for unit test. Use this command on the console to run tests
```
bundle exec rspec
```