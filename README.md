# Tournament
=============

## Description
In this project, a database schema was created, i.e. using a Python module that uses PostgreSQL, to store tournament matches between players -- Swiss system style. In a Swiss system tournament, players are not eliminated in each round, rather they are systematically paired with another player with the same number of wins. After creating the database schema (SQL file), a separate file (python module) was used to query the tables to report winners and matches of each round.

## Necessary files
Starter codes are provided for this project and must be forked from Udacity's fullstack-nanodegree-vm reposistory. Once cloned into your local machine, you will find the following files(3):

- tournament.sql : a file used to create tables  
- tournament.py  : a file used to manipulate data in the database in Python
- tournament_test.py : a file containing test cases to test implementation of functions in tournament.py

Most importantly, to successfully run the tournament.sql file, make sure you delete the database if it exists, create the database, then connect to it.

## How to setup environment
In order to successfully run the application, the Vagrant virtual machine must be set up properly. This includes installing Vagrant and Virtual Box. 

## How to execute tests?
In the vagrant environment:
1. Navigate to 'cd /vagrant/tournament'
2. Enter psql -f tournament.sql to fetch the tournament databse schema.
3. Open another tab on the terminal.
4. Execute the command 'python tournament_test.py' to test the methods.
5. Test results should print sucessfully on the screen.
