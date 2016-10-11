-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

--"You want to use the computer for repetitive stuff so you can use your brain for hard stuff." -Philip


DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

CREATE TABLE players
(id SERIAL 
PRIMARY KEY, 
name TEXT);

CREATE TABLE matches
(match_id SERIAL PRIMARY KEY,
winner SERIAL REFERENCES players(id),
loser SERIAL REFERENCES players(id));

/* Create match count view */
CREATE VIEW matches_played AS
SELECT id, name, COUNT(matches.match_id) AS played
FROM players
LEFT JOIN matches
ON players.id = matches.winner OR players.id = matches.loser
GROUP BY players.id;

/* Create win count view */
CREATE VIEW player_wins AS
SELECT id, name, COUNT(matches.winner) AS wins
FROM players
LEFT JOIN matches
ON players.id = matches.winner
GROUP BY id
ORDER BY wins DESC;

/* Create standings view */
CREATE VIEW standings AS
SELECT matches_played.id, matches_played.name,
COALESCE (player_wins.wins,0) AS wins,
COALESCE (matches_played.played,0) AS played
FROM matches_played
LEFT JOIN player_wins
ON matches_played.id = player_wins.id
ORDER BY wins DESC;

/* Create swisspairing view */
CREATE VIEW swisspairing AS
SELECT matches_played.id, matches_played.name,
COALESCE (player_wins.wins,0) AS wins,
COALESCE (matches_played.played,0) AS played
FROM matches_played
LEFT JOIN player_wins
ON matches_played.id = player_wins.id
ORDER BY wins DESC;

--ALTER TABLE players ADD COLUMN wins INTEGER, ADD COLUMN matches_played INTEGER;
--ALTER TABLE players DROP COLUMN player_wins;
--DETAIL: view standings depends on view player_wins HINT:  Use DROP ... CASCADE to drop the dependent objects too.
