require_relative( 'models/home_team' )
require_relative( 'models/away_team' )
require_relative( 'models/home_team_lineup' )
require_relative( 'models/away_team_lineup' )
require_relative( 'models/match' )
require_relative( 'db/sql_runner' )
require( 'pry-byebug' )

runner = SqlRunner.new({dbname: 'dodgeball', host: 'localhost'})


Match.delete_all( runner )
HomeTeam.delete_all( runner )
AwayTeam.delete_all( runner )
HomeTeamLineup.delete_all( runner )
# AwayTeamLineup.delete_all( runner )

home_team1 = HomeTeam.new( {"name" => "Dodgy Bastards"}, runner)
ht1 = home_team1.save()
home_team2 = HomeTeam.new( {"name" => "Match Throwers"}, runner)
ht2 = home_team2.save()

away_team1 = AwayTeam.new( {"name" => "The Tossers"}, runner)
at1 = away_team1.save()

away_team2 = AwayTeam.new( {"name" => "Big Red Balls"}, runner)
at2 = away_team2.save()

home_team_lineup1 = HomeTeamLineup.new( {"catcher_1" => "Fingers Jones", "catcher_2" => "Immortal Jane", "corner_1" => "Big Dave", "corner_2" => "Jack Tash", "sniper_1" => "Bobby Jr Sr", "sniper_2" => "Rubbish John", "thrower_1" => "All Talk Harrison", "thrower_2" => "Magic Mike", "home_team_id" => ht1.id}, runner )
htl1 = home_team_lineup1.save()

away_team_lineup1 = AwayTeamLineup.new( {"catcher_1" => "Missy Lots", "catcher_2" => "Immortal Iain", "corner_1" => "Jon St John", "corner_2" => "Major Leaks", "sniper_1" => "Bobby Sr Jr", "sniper_2" => "Decent John", "thrower_1" => "Big Mouth Robinson", "thrower_2" => "Mecha Rambo", "away_team_id" => at1.id}, runner )
atl1 = away_team_lineup1.save()

match1 = Match.new( {"home_team_id" => ht1.id, "away_team_id" => at1.id}, runner )
match1.save()

match2 = Match.new( {"home_team_id" => ht2.id, "away_team_id" => at2.id}, runner )
match2.save()

match1.final_score(3,2)
match2.final_score(5,9)

binding.pry
nil