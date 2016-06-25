require_relative('../db/sql_runner')

class League

  def initialize( options, runner )
    @id = options['id'].to_i
    @matches = Match.all(runner)
    @runner = runner
  end

  def save()
    sql = "INSERT INTO leagues ( id ) VALUES ( #{@id} )"
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



end






