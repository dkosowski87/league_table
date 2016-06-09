class MatchTable < Array

	def initialize(league_table)
		@league_table = league_table
	end

	%w(push <<).each do |method_name|
		define_method(method_name) do |*matches|
		 	super(*matches)
		 	matches.each { |match| @league_table.update_standings(match) }
		end
	end

	%w(shift unshift pop insert delete_at delete delete_if keep_if replace
		reject! slice! select! map! collect! uniq! []= + -).each do |method_name|
		define_method(method_name) do |*args, &block|
		 	super(*args, &block)
		 	@league_table.reset_standings
		end
	end

end