require_relative('../db/sql_runner')

class League

  def initialize( options, runner )
    @id = options['id'].to_i
    @match_id = options['match_id'].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO leagues ( match_id ) VALUES ( #{@match_id} )"
    @runner.run( sql )
  end

  def self.all( runner )
    sql = "SELECT * FROM leagues;"
    leagues = runner.run( sql )
    result = leagues.map { |league| League.new( league, runner )}
    return result
  end

  def self.delete_all( runner )
    sql = "DELETE FROM leagues"
    runner.run( sql )
  end

  # def final_score( home_goals, away_goals)
  #   sql = "UPDATE matches SET home_team_score = #{home_goals}, away_team_score = #{away_goals} WHERE home_team_id = #{@home_team_id} "
  #   @runner.run( sql )
  # end

end






