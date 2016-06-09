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

	%w(unshift insert pop shift delete_at delete []= reject! 
		slice! select! map! uniq! keep_if collect!).each do |method_name|
		define_method(method_name) do |*args, &block|
		 	super(*args, &block)
		 	@league_table.reset_standings
		end
	end

	# instance_methods.select { |method_name| method_name.to_s.match /[a-z]/ }.each do |method_name|
	# 	define_method(method_name) do |*args, &block|
	# 		super(*args, &block)
	# 		@league_table.reset_standings
	#  	end
	# end

end