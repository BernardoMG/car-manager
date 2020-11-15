[![Build Status](https://travis-ci.com/BernardoMG/car-manager.svg?token=zJz33RY7FtoBwrYp4yBw&branch=main)](https://travis-ci.com/BernardoMG/car-manager)

# Car Manager Service

## How to build and run the app

1. Run `docker-compose build`
2. Run `docker-compose up -d backend db`

On another window run: 

3. Run `docker-compose run backend rake db:setup`

## How to run application tests

Run `docker-compose run test`