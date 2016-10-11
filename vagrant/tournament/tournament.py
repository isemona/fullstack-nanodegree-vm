#!/usr/bin/env python
# 
# tournament.py -- implementation of a Swiss-system tournament
#

#!/usr/bin/env python
#
# tournament.py -- implementation of a Swiss-system tournament
#

import psycopg2

import bleach

def connect(database_name="tournament"):
    """Connect to the PostgreSQL database. Returns a database connection."""
    try:
        db = psycopg2.connect("dbname={}".format(database_name))
        c = db.cursor()
        return db, c
    except:
        print("<error message>")

def deleteMatches():
    """Remove all the match records from the database."""
    db, c = connect()
    
    query = "DELETE FROM matches;"
    c.execute(query)
    
    db.commit()
    db.close()
    print "matches deleted"


def deletePlayers():
    """Remove all the player records from the database."""
    db, c = connect()
    
    query = "DELETE FROM players;"
    c.execute(query)
    
    db.commit()
    db.close()
    print "players deleted"


def countPlayers():
    """Returns the number of players currently registered."""
    db, c = connect()
    
    query = "SELECT COUNT(*) FROM players;"
    c.execute(query)
    registered_players = c.fetchone()[0]
    
    db.commit()
    db.close()
    return registered_players


def registerPlayer(name):
    """Adds a player to the tournament database.

    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)

    Args:
      name: the player's full name (need not be unique).
    """
    clean_name = bleach.clean(name)
    print clean_name
    
    db, c = connect()
    
    query = "INSERT INTO players(name) VALUES(%s)"
    parameter = (clean_name,)
    c.execute(query, parameter)

    db.commit()
    db.close()


def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place,
    or a player tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    db, c = connect()
    
    query = "SELECT * FROM standings"
    c.execute(query)
    rows = c.fetchall()
    
    db.commit()
    db.close()
    return rows


def reportMatch(winner,loser):
    """Records the outcome of a single match between two players.

    Args:
      winner:  the id number of the player who won
      loser:  the id number of the player who lost
    """
    db, c = connect()
    
    query = "INSERT INTO matches(winner,loser) VALUES (%s,%s)"
    parameter = (winner,loser,)
    c.execute(query, parameter)
    
    db.commit()
    db.close()
    
def swissPairings():
    """Returns a list of pairs of players for the next round of a match.

    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent
    to him or her in the standings.

    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """

    standings = playerStandings()
    
    pairs = []

    zipped = zip(standings[0::2], standings[1::2])

    for p1, p2 in zipped:
        pairs.append((p1[0], p1[1], p2[0], p2[1]))

    return pairs
