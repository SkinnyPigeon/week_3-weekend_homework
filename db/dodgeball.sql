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