class Team
	attr_reader :name, 
							:points, 
							:wins, :draws, :losses, 
							:goals_for, :goals_against

	def initialize(name)
		@name = name
		@points = 0
		@wins, @draws, @losses = 0, 0, 0
		@goals_for, @goals_against = 0, 0
	end

	def goal_difference
		goals_for - goals_against
	end

	def win(goals_scored, goals_conceded)
		@points += 3
		@wins += 1
		update_goals(goals_scored, goals_conceded)
	end

	def draw(goals_scored, goals_conceded)
		@points += 1
		@draws += 1
		update_goals(goals_scored, goals_conceded)
	end

	def lose(goals_scored, goals_conceded)
		@losses += 1
		update_goals(goals_scored, goals_conceded)
	end

	private
	def update_goals(goals_scored, goals_conceded)
		@goals_for += goals_scored
		@goals_against += goals_conceded
	end
	
end