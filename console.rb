require_relative( 'models/home_team' )
require_relative( 'models/away_team' )
require_relative( 'models/match' )
require_relative( 'db/sql_runner' )
require( 'pry-byebug' )

runner = SqlRunner.new({dbname: 'dodgeball', host: 'localhost'})


Match.delete_all( runner )
HomeTeam.delete_all( runner )
AwayTeam.delete_all( runner )

home_team1 = HomeTeam.new( {"name" => "Dodgy Bastards"}, runner)
ht1 = home_team1.save()

away_team1 = AwayTeam.new( {"name" => "The Tossers"}, runner)
at1 = away_team1.save()

match1 = Match.new( {"home_team_id" => ht1.id, "away_team_id" => at1.id}, runner )
match1.save()

match1.final_score(3,2)

binding.pry
nil