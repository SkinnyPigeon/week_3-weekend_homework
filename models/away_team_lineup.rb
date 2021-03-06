require_relative('../db/sql_runner')
require('pry-byebug')

class AwayTeamLineup

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
    @away_team_id = options['away_team_id'].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO away_teams_lineups (catcher_1, catcher_2, corner_1, corner_2, sniper_1, sniper_2, thrower_1, thrower_2, away_team_id) VALUES ('#{catcher_1}', '#{catcher_2}', '#{corner_1}', '#{corner_2}', '#{sniper_1}', '#{sniper_2}', '#{thrower_1}', '#{thrower_2}', #{@away_team_id}) RETURNING *"
    return AwayTeamLineup.map_item( sql, @runner )
  end

  def self.all( runner )
    sql = "SELECT * FROM away_teams_lineups"
    return AwayTeamLineup.map_items( sql, runner )
  end

  def self.delete_all( runner )
    sql = "DELETE FROM away_teams_lineups"
    runner.run( sql )
  end

  def opponents()
    sql = "SELECT home_teams_lineups.* FROM home_teams_lineups
          INNER JOIN home_teams ON home_teams.id = home_teams_lineups.home_team_id
          INNER JOIN matches ON matches.home_team_id = home_teams.id
          WHERE away_team_id = #{@away_team_id}"
    return AwayTeamLineup.map_item( sql, @runner )
  end

  def team()
    sql = "SELECT * FROM away_teams_lineups WHERE away_team_id = #{@away_team_id}"
    result = @runner.run( sql )
    return result.first
  end

  def self.map_items( sql, runner )
    away_teams_lineups = runner.run( sql )
    result = away_teams_lineups.map { |home_team_lineup| AwayTeamLineup.new( home_team_lineup, runner ) }
    return result
  end

  def self.map_item( sql, runner )
    result = AwayTeamLineup.map_items( sql, runner )
    return result.first
  end

  def update_lineup( options )
    if options['catcher_1']
      @catcher_1=options['catcher_1']
    end
    if options['catcher_2']
      @catcher_2=options['catcher_2']
    end
    if options['corner_1']
      @corner_1=options['corner_1']
    end
    if options['corner_2']
      @corner_2=options['corner_2']
    end
    if options['sniper_1']
      @sniper_1=options['sniper_1']
    end
    if options['sniper_2']
      @sniper_2=options['sniper_2']
    end
    if options['thrower_1']
      @thrower_1=options['thrower_1']
    end
    if options['thrower_2']
      @thrower_2=options['thrower_2']
    end

    id = options['id'].to_i

    sql = "UPDATE away_teams_lineups SET
      catcher_1 = '#{ @catcher_1 }',
      catcher_2 = '#{ @catcher_2 }',
      corner_1 = '#{ @corner_1 }',
      corner_2 = '#{ @corner_2 }',
      sniper_1 = '#{ @sniper_1 }',
      sniper_2 = '#{ @sniper_2 }',
      thrower_1 = '#{ @thrower_1}',
      thrower_2 = '#{ @thrower_2 }'"

      @runner.run( sql )
  end

end








