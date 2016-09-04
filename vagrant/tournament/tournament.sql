-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


Tournament Tables (psql)

CREATE TABLE players (id SERIAL PRIMARY KEY, name TEXT);

CREATE TABLE matches 
(match_id INTEGER PRIMARY KEY, 	
winner INTEGER REFERENCES players(id), 
loser INTEGER REFERENCES players(id));

/* Create match count view */
CREATE VIEW matches_played AS
SELECT id, name, COUNT(players.id) AS played
FROM players, matches
WHERE players.id = matches.winner OR players.id = matches.loser
GROUP BY id;

/* Create win count view */
CREATE VIEW player_wins AS
SELECT id, name, COUNT (matches.winner) AS wins
FROM players, matches
GROUP BY id
ORDER BY wins DESC;

/* Create standings view */
CREATE VIEW standings AS
SELECT * FROM matches_played
LEFT JOIN player_wins
ON players.id = matches.winner
ORDER BY wins DESC;

SELECT TWO TABLES WITH JOINS SO YOU CAN SEE THE WINS NEXT TO THEIR NAME

