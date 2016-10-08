rdb-fullstack
=============

Common code for the Relational Databases and Full Stack Fundamentals courses
# tournament-project

In this project, a database schema was created, i.e. using a Python module that uses PostgreSQL, to store tournament matches between players -- Swiss system style. In a Swiss system tournament, players are not eliminated in each round, rather they are systematically paired with another player with the same number of wins. After creating the database schema (SQL file), a separate file (python module) was used to query the tables to report winners and matches of each round.


In order to successfully run the application, the Vagrant virtual machine must be set up properly. This includes installing Vagrant and Virtual Box. 

Aside from this, a starter code is provided for this project and must be forked from Udacity's fullstack-nanodegree-vm reposistory. Once cloned into your local machine, you will find the following files(3):

- tournament.sql : used to create my tables  
- tournament.py  : used to manipulate data in the database in Python
- tournament_test.p : test cases to test implementation of fuctions in tournament.py 
