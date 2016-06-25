require_relative('../db/sql_runner')
require('pry-byebug')

class HomeTeam

  attr_reader( :id, :name )

  def initialize( options, runner ) 
    @id = options['id'].to_i
    @name = options['name']
    @runner = runner
  end

  def save()
    sql = "INSERT INTO home_teams (name) VALUES ('#{ @name }') RETURNING *"
    return HomeTeam.map_item( sql, @runner )
  end

  def self.all( runner )
    sql = "SELECT * FROM home_teams"
    return HomeTeam.map_items( sql, runner )
  end

  def self.delete_all( runner )
    sql = "DELETE FROM home_teams"
    runner.run( sql )
  end

  def games()
    sql = "SLECT a.* from away_teams a INNER JOIN matches m ON m.away_team_id = a.id WHERE home_team_id = #{@id}"
    return AwayTeam.map_items( sql, @runner )
  end

  def self.map_items( sql, runner )
    home_teams = runner.run( sql )
    result = home_teams.map { |home_team| HomeTeam.new( home_team, runner ) }
    return result
  end

  def self.map_item( sql, runner )
    result = HomeTeam.map_items( sql, runner )
    return result.first
  end

end