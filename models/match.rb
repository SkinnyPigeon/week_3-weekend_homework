require_relative('../db/sql_runner')

class Match

  attr_reader(:id)

  def initialize( options, runner )
    @id = options['id'].to_i
    @home_team_id = options['home_team_id'].to_i
    @away_team_id = options['away_team_id'].to_i
    @home_team_score = options['home_team_score'].to_i
    @away_team_score = options['away_team_score'].to_i
    @runner = runner
  end

  def save()
    sql = "INSERT INTO matches ( home_team_id, away_team_id ) VALUES ( #{@home_team_id}, #{@away_team_id} ) RETURNING *"
    return Match.map_item( sql, @runner )
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

  def self.map_items( sql, runner )
    matches = runner.run( sql )
    result = matches.map { |match| Match.new( match, runner ) }
    return result
  end

  def self.map_item( sql, runner )
    result = Match.map_items( sql, runner )
    return result.first
  end

  def final_score( home_goals, away_goals)
    sql = "UPDATE matches SET home_team_score = #{home_goals}, away_team_score = #{away_goals} WHERE home_team_id = #{@home_team_id} "
    @runner.run( sql )
  end

end






