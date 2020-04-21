# Sweater Weather API

## Description

Sweater Weather API is the back-end in a service-oriented architecture for a fictional application to plan road trips.

[Deployed on Heroku](https://da-sweater-weather.herokuapp.com/) 

(note: There is no page for the root path. Data can only be accessed via endpoints. [See an example](https://da-sweater-weather.herokuapp.com/api/v1/backgrounds?location=perth,au))



## Setting Up

#### Requirements:
- Ruby 2.5.1
- PostgreSQL 12.1

#### Installation:

```
$ git clone git@github.com:d-atkins/sweater-weather-api.git
$ cd sweater-weather-api
$ bundle   
$ rails db:{drop,create,migrate}   
$ bundle exec figaro install
```

##### Environment Variables:
The following API keys are required:

Google API key - you must enable `Geocoding` and `Directions` for your API key

Open Weather API key

Flickr API key

Add the following environment variables to your `config/application.yml` file.

```
GEOCODE_API_KEY: <YOUR_GOOGLE_API_KEY>
OPEN_WEATER_API_KEY: <YOUR_OPEN_WEATHER_API_KEY>
FLICKR_API_KEY: <YOUR_FLICKR_API_KEY>
```

## Tests
To run the test suite, run the following command: `bundle exec rspec`. The test suite relies on [VCR Cassettes](https://github.com/vcr/vcr) to run. Making changes may require you to delete your cassettes in `./spec/fixtures/vcr_cassettes` and re-record them by running `bundle exec rspec`

## Endpoints
Production domain: `https://da-sweater-weather.herokuapp.com`

Development domain: `http:localhost:3000`

All requests must be made in JSON. All responses are sent in JSON. 

Sweater Weather API supports the following endpoints. See below for details on required body/parameter contents.
```
GET /api/v1/forecast
GET /api/v1/backgrounds
POST /api/v1/users
POST /api/v1/sessions
POST /api/v1/road_trip
```

#### Retrieving weather for a city
Params
```
location(required)
```
Example Request
```
GET /api/v1/forecast?location=denver,co
```
Example Response
```
{
  data: {
    id: null,
    type: "forecast_facade",
    attributes: {
    location: "Denver, CO, USA",
    current: {
      unix_time: 1587494091,
      weather: [
        {
        id: 802,
        main: "Clouds",
        description: "scattered clouds",
        icon: "03d"
        }
      ],
      timezone: "America/Denver",
      temp: 63,
      feels_like: 56,
      humidity: 29,
      visibility: 10,
      uvi: 8.05,
      unix_sunrise: 1587471164,
      unix_sunset: 1587519838,
      current_time: "12:34 PM, April 21"
    },
    hourly: [...],
    daily: [...]
    }
  }
}
```
Hourly Data
```
{
unix_time: 1587492000,
  weather: [
    {
      id: 802,
      main: "Clouds",
      description: "scattered clouds",
      icon: "03d"
    }
  ],
  timezone: "America/Denver",
  temp: 63,
  time: "12 PM"
}
```
Daily Data
```
{
  unix_time: 1587492000,
  weather: [
    {
      id: 500,
      main: "Rain",
      description: "light rain",
      icon: "10d"
    }
  ],
  timezone: "America/Denver",
  min: 55,
  max: 66,
  day: "Tuesday"
}
```

#### Background Image for a City
Params
```
location(required)
```
Example Request
```
GET /api/v1/backgrounds?location=denver,co
```
Example Response
```
{
  data: {
    id: null,
    type: "background",
    attributes: {
      url_o: "https://live.staticflickr.com/65535/49057077877_515f02f67b_o.jpg",
      url_l: "https://live.staticflickr.com/65535/49057077877_fa993cd95b_b.jpg",
      title: "D E N V E R"
    }
  }
}
```

#### Registration
Example Request
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "unagi@example.com",
  "password": "burgers",
  "password_confirmation": "burgers"
}
```
Example Response
```
{
  "data": {
    "id": "3",
    "type": "users",
    "attributes": {
        "email": "unagi@example.com",
        "api_key": "1q2w3e4r5t6y7u8i9o"
    }
  }
}
```

#### Login
Example Request
```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "unagi@example.com",
  "password": "burgers"
}
```
Example Response
```
{
  "data": {
    "id": "3",
    "type": "users",
    "attributes": {
      "email": "unagi@example.com",
      "api_key": "1q2w3e4r5t6y7u8i9o"
    }
  }
}
```

#### Road Trip
Example Request
```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "1q2w3e4r5t6y7u8i9o"
}
```
Example Response
```
{
  "data": {
    "id": null,
    "type": "road_trip_facade",
    "attributes": {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "travel_time": "1 hour, 48 minutes",
      "arrival_forecast": {
        "unix_time": 1587502800,
        "weather": [
          {
            "id": 802,
            "main": "Clouds",
            "description": "scattered clouds",
            "icon": "03d"
          }
        ],
        "timezone": "America/Denver",
        "temp": 67,
        "time": "3 PM"
      }
    }
  }
}
```
