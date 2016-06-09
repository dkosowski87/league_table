class MatchTable < Array

	def initialize(league_table)
		@league_table = league_table
	end

	# Public: Dynamically overriding array methods that allow for pushing to the MatchTable object.
	# 				A callback is added to execute the update_standings method on the LeagueTable object
	#         after an element is added to the matches array (MatchTable object).
	%w(push <<).each do |method_name|
		define_method(method_name) do |*matches|
		 	super(*matches)
		 	matches.each { |match| @league_table.update_standings(match) }
		end
	end

	# Public: Dynamically overriding array methods that allow for changing to the MatchTable object.
	# 				A callback is added to execute the reset_standings method on the LeagueTable object
	#         after the matches array (MatchTable object) is changed.
	#         This may be an incomprehensive list of methods. 
	#         It is advised to use the ones listed below.
	%w(shift unshift pop insert delete_at delete delete_if keep_if replace
		reject! slice! select! map! collect! uniq! []= + -).each do |method_name|
		define_method(method_name) do |*args, &block|
		 	super(*args, &block)
		 	@league_table.reset_standings
		end
	end

end