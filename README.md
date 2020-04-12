Description
===
this app is a demo back end for a trip app.
main components and gems used:

1-Docker
========
this app uses docker for setting up the environment and along with docker compose.
there are four images as follows:
  1- an image for the rails app
  2- an image for sidekiq
  3- an image for mysql
  4- an image for redis which is used by sidekiq for scheduling the jobs
  
2- Sidekiq
==========
it is used for scheduling the jobs. check the workers dir which contains one worker currently in order to know more.

3- Caching
==========
used the default rails cashing only on the model leve (for the trips model only ) for the sake of simplicity in this small app
however better options like memecached and dalli would server better for real world apps
see the index action of the trips controller and the trip modle to learn more about it.

4- Serializing
============
I used the active model serializer gem in this app for serializing the model into consumed data for the api response.

5- Interactors
=============
to make the bussiness logic sperated form the io of the web (controllers) I used the interactors gem, it simply embraces the Facade, Command, Chain of responsibilty patterns to make the app more moduler and reveals its intent from the folder structure. and the interactors manages the interaction of the system objects. resulting in the bussiness rules gets implemented in a clear way with a better code quality. which is an overkill for this small app.

6-AASM
==========
for defining and managing status transition of the trip model I used the AASM gem.

7-Testing
=========
I used rspec, factorybot, and faker for in the testing suite of this app, a long with sidekiq and aasm to help test workers and model stauses.
all tests are written for the app in advance followin a the TDD approach of writin tests before writing the actual code and following the red-green cycle.
please move to the how to run the app section to know how to run it and as well how to run the tests.
I was lazy to test the serializers just for the sake of keeping it simple as it is a demo app.








How to run the app
====

to run the app please follow  the following steps: 

1-clone the repo
=========
`git clone https://github.com/Abdullah-F/trip_back_end.git`

2- go the cloned dircorty
=========
3- for starting up the app type:
=========
`docker-compose up -d` then it should be available on <a href='http://localhost'> localhost </a>
<br>

[NOTE] please note that I do not check in the etry point if the db is up or not so the app can wait for the db if the command faild to start the app just run it agian it will start it by then on port 3000 in your local host

4- for running the tests run:
=========
`docker exec -it trip_back_end_app_1 bundle exec rspec` you shuould see all the green dots for this app in less than 1.8s.



Things To be done
====

1-user better cashing other than the default store for rails.
<br>
2-most imprtantly tests bye now are only unit tests for controllers, interactors, models, etc all in isolation. so no integration tests are witten by now. so adding itegration tests is important just to tests the state of the app as a whole.
<br>
3-tests serialzers.

Contribution
===============
pull & update & sumit your MR, all will be welcomed.
any thoughts futher disscussions are all welocme from anyone.
