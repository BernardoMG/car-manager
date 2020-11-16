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
<img width="948" alt="Screenshot 2020-11-16 at 12 11 03" src="https://user-images.githubusercontent.com/11138222/99251188-d0068300-2804-11eb-8e8d-59caf3066484.png">

2. Models
<img width="613" alt="Screenshot 2020-11-16 at 12 07 50" src="https://user-images.githubusercontent.com/11138222/99250992-861d9d00-2804-11eb-85ab-556e8c49d12f.png">

3. Makers
<img width="583" alt="Screenshot 2020-11-16 at 12 09 39" src="https://user-images.githubusercontent.com/11138222/99251066-9d5c8a80-2804-11eb-8e36-46caba4f8d6b.png">

4. Colors
<img width="625" alt="Screenshot 2020-11-16 at 12 10 01" src="https://user-images.githubusercontent.com/11138222/99251102-ab121000-2804-11eb-8362-97388f36fd43.png">

5. Model Colors
<img width="624" alt="Screenshot 2020-11-16 at 12 10 27" src="https://user-images.githubusercontent.com/11138222/99251133-b9f8c280-2804-11eb-8ef5-6a4c210fab23.png">

You can also see the db schema [here](https://github.com/BernardoMG/car-manager/blob/main/backend/db/schema.rb).
