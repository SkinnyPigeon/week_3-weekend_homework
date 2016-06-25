require_relative('../db/sql_runner')
require('pry-byebug')

class HomeTeamLineup

  attr_reader( :id, :catcher_1, :catcher_2, :corner_1, :corner_2, :sniper_1, :sniper_2, :thrower_1, :thrower_2 )

  def initialize( options, runner )
    @id = options['id'].to_i
    @catcher_1 = options['catcher_1']
    @catcher_2 = options['catcher_2']
    @corner_1 = options['corner_1']
    @corner_2 = options['corner_2']
    @sniper_1 = options['sniper_1']
    @sniper_2 = options['sniper_2']
    @thrower_1 = options['thrower_1']
    @thrower_2 = options['thrower_2']
    @home_team_id = options['home_team_id'].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO home_teams_lineups (catcher_1, catcher_2, corner_1, corner_2, sniper_1, sniper_2, thrower_1, thrower_2, home_team_id) VALUES ('#{catcher_1}', '#{catcher_2}', '#{corner_1}', '#{corner_2}', '#{sniper_1}', '#{sniper_2}', '#{thrower_1}', '#{thrower_2}', #{@home_team_id}) RETURNING *"
    return HomeTeamLineup.map_item( sql, @runner )
  end

  def self.all( runner )
    sql = "SELECT * FROM home_teams_lineups"
    return HomeTeamLineup.map_items( sql, runner )
  end

  def self.delete_all( runner )
    sql = "DELETE FROM home_teams_lineups"
    runner.run( sql )
  end

  def opponents()
    sql = "SELECT a.* FROM away_teams_lineups a INNER JOIN matches m on m.away_team_id = a.id WHERE home_team_id = #{@id}"
    return AwayTeamLineup.map_items( sql, @runner )
  end

  def self.map_items( sql, runner )
    home_teams_lineups = runner.run( sql )
    result = home_teams_lineups.map { |home_team_lineup| HomeTeamLineup.new( home_team_lineup, runner ) }
    return result
  end

  def self.map_item( sql, runner )
    result = HomeTeamLineup.map_items( sql, runner )
    return result.first
  end

end







