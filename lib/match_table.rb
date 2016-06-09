class MatchTable < Array

	def initialize(league_table)
		@league_table = league_table
	end

	def push(*matches)
		super(*matches)
		matches.each { |match| @league_table.update_standings(match) }
	end
end