DROP TABLE home_teams_lineups;
DROP TABLE away_teams_lineups;
DROP TABLE leagues;
DROP TABLE matches;
DROP TABLE home_teams;
DROP TABLE away_teams;


CREATE TABLE home_teams (
  id SERIAL4 primary key,
  name VARCHAR(255)
);

CREATE TABLE away_teams (
  id SERIAL4 primary key,
  name VARCHAR(255)
);

CREATE TABLE matches (
  id SERIAL4 primary key,
  home_team_score INT4,
  away_team_score INT4,
  home_team_id INT4 references home_teams(id),
  away_team_id INT4 references away_teams(id)
);

CREATE TABLE leagues (
  id SERIAL4 primary key,
  match_id INT4 references matches(id)
);

CREATE TABLE home_teams_lineups (
  id SERIAL4 primary key,
  catcher_1 VARCHAR(255) not null,
  catcher_2 VARCHAR(255) not null,
  corner_1 VARCHAR(255) not null,
  corner_2 VARCHAR(255) not null,
  sniper_1 VARCHAR(255) not null,
  sniper_2 VARCHAR(255) not null,
  thrower_1 VARCHAR(255) not null,
  thrower_2 VARCHAR(255) not null,
  home_team_id INT4 references home_teams(id)
);

CREATE TABLE away_teams_lineups (
  id SERIAL4 primary key,
  catcher_1 VARCHAR(255) not null,
  catcher_2 VARCHAR(255) not null,
  corner_1 VARCHAR(255) not null,
  corner_2 VARCHAR(255) not null,
  sniper_1 VARCHAR(255) not null,
  sniper_2 VARCHAR(255) not null,
  thrower_1 VARCHAR(255) not null,
  thrower_2 VARCHAR(255) not null,
  away_team_id INT4 references away_teams(id)
);


















