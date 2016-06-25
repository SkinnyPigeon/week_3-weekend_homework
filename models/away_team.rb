require_relative('../db/sql_runner')
require('pry-byebug')

class AwayTeam

  attr_reader( :id, :name )

  def initialize( options, runner ) 
    @id = options['id'].to_i
    @name = options['name']
    @runner = runner
  end

  def save()
    sql = "INSERT INTO away_teams (name) VALUES ('#{ @name }') RETURNING *"
    return AwayTeam.map_item( sql, @runner )
  end

  def self.all( runner )
    sql = "SELECT * FROM away_teams"
    return AwayTeam.map_items( sql, runner )
  end

  def self.delete_all( runner )
    sql = "DELETE FROM away_teams"
    runner.run( sql )
  end

  def games()
    sql = "SLECT h.* from home_teams a INNER JOIN matches m ON m.home_team_id = h.id WHERE away_team_id = #{@id}"
    return HomeTeam.map_items( sql, @runner )
  end

  def self.map_items( sql, runner )
    away_teams = runner.run( sql )
    result = away_teams.map { |home_team| AwayTeam.new( home_team, runner ) }
    return result
  end

  def self.map_item( sql, runner )
    result = AwayTeam.map_items( sql, runner )
    return result.first
  end

end