require_relative('../db/sql_runner')

class Match

  def initialize( options, runner )
    @id = options['id'].to_i
    @home_team_id = options['home_team_id'].to_i
    @away_team_id = options['away_team_id'].to_i
    @home_team_score = options['home_team_score'].to_i
    @away_team_score = options['away_team_score'].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO matches ( home_team_id, away_team_id ) VALUES ( #{@home_team_id}, #{@away_team_id} )"
    @runner.run( sql )
  end

  def self.all( runner )
    sql = "SELECT * FROM matches;"
    matches = runner.run( sql )
    result = matches.map { |match| Match.new( match, runner )}
    return result
  end

  def self.delete_all( runner )
    sql = "DELETE FROM matches"
    runner.run( sql )
  end

  def final_score( home_goals, away_goals)
    sql = "INSERT INTO matches ( home_team_score, away_team_score) VALUES (#{home_goals}, #{away_goals})"
    @runner.run( sql )
  end

end









