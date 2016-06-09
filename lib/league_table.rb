class LeagueTable
	attr_reader :matches

	def initialize
		@matches = MatchTable.new(self)
		@teams = []
	end

	# Internal: Updates the standings - points, goals, results of teams in a match.
	#
	# match - a string in the format "Home Team 0 - 0 Away Team",
	# 				includes the teams and goals for update.
	def update_standings(match)
		home_team, away_team = get_match_teams(match) 
		home_team_goals, away_team_goals = get_match_goals(match)
		save_match_result(home_team, home_team_goals, away_team_goals)
		save_match_result(away_team, away_team_goals, home_team_goals)
	end

	# Internal: Resets the team standings in a league - points, goals, results of
	#           teams in a match. Clears the team instance variable and uses the 
	#           update_standings method to create new teams and standings.
	def reset_standings
		@teams.clear
		@matches.each { |match| update_standings(match) }
	end

	# Public: Dynamically created methods that allow for retrieving stats of a team.
	#
	# team_name - a string with the team name.
	%w(points goals_for goals_against goal_difference wins losses draws).each do |name|
		define_method("get_#{name}") do |team_name|
			team = find_team(team_name)
			team ? team.send(name) : 0
		end
	end

	private
	def add_team(team_name)
		team = Team.new(team_name)
		@teams << team and return team
	end

	def find_team(team_name)
		@teams.find { |team| team.name == team_name }
	end

	def get_match_teams(match)
		match.split(/\s\d+\s-\s\d+\s/).
		map { |team_name| find_team(team_name) || add_team(team_name) }
	end

	def get_match_goals(match)
		match.slice(/\d+\s-\s\d+/).split(/\s-\s/).map{ |goals| goals.to_i }
	end

	def save_match_result(team, team_goals, opponent_goals)
		result = :win if team_goals > opponent_goals
		result = :lose if team_goals < opponent_goals
		result = :draw if team_goals == opponent_goals
		team.send(result, team_goals, opponent_goals)
	end	

end