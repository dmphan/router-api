# README

This app exposes an API endpoint: `GET /routes` that accepts two params: `from` and `to`. These params accept valid coordinate points as a string in the form of: `{long},{lat}`.

The endpoint returns a JSON object:

```
{
  total_distance: ...,
  points: [[]]
}
```

`total_distance`: (Double) the total distance of the route in meters

`points`: (Array of Array) the coordinates along the route with elevation

Each sub-array in the `points` array is: `[long, lat, elevation]`

## Ruby + Rails version
  Ruby: 2.7.7
  
  Rails: 7.0.2

## System dependencies
  * Redis
  * [Uber H3 build-time dependencies](https://github.com/uber/h3#install-build-time-dependencies)

## Setup

Ensure all dependences are installed.

Run the following commands:

`bundle install`

`foreman start -f Procfile.dev`

