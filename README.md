[![Build Status](https://travis-ci.com/BernardoMG/car-manager.svg?token=zJz33RY7FtoBwrYp4yBw&branch=main)](https://travis-ci.com/BernardoMG/car-manager)

# Car Manager Service

## How to build and run the app

1. Run `docker-compose build`
2. Run `docker-compose up -d backend db`

On another window run (make sure that both containers are up and running): 

3. Run `docker-compose run backend rake db:setup`

## How to run application tests

Run `docker-compose run test`. (You only need to have db container up.)

##### Note: I've also setup Travis CI for this repository. You can check its badge on top of this page ✅. First time using docker on travis.yml 🚀🙌.

# API Documentation

# DB Schema

We have 5 tables: cars, models, makers, colors and model_colors (join table between models and colors). There's the schema for each table:

1. Cars

2. Models

3. Makers

4. Colors

5. Model Colors