require 'spec_helper'

RSpec.describe LeagueTable do

	let!(:league_table) { LeagueTable.new }

	describe '#matches' do	
		it "returns an empty array when no matches are provided" do
			expect(league_table.matches).to eq([])
		end

		it "returns an array of matches when matches are provided" do
			league_table.matches.push("Man Utd 3 - 0 Liverpool", "Liverpool 1 - 1 Man Utd")
			expect(league_table.matches).to include("Man Utd 3 - 0 Liverpool")
			expect(league_table.matches).to include("Liverpool 1 - 1 Man Utd")
		end
	end

	describe '#update_standings' do
		before(:example) do
			league_table.update_standings("Man Utd 10 - 0 Schalke 04")
			league_table.update_standings("Schalke 04 3 - 3 Man Utd")
		end

		it "updates the points of the teams that played a match" do
			expect(league_table.get_points("Man Utd")).to eq(4)
			expect(league_table.get_points("Schalke 04")).to eq(1)
		end

		it "updates the goals_for of the teams that played a match" do
			expect(league_table.get_goals_for("Man Utd")).to eq(13)
			expect(league_table.get_goals_for("Schalke 04")).to eq(3)
			expect(league_table.get_goals_against("Man Utd")).to eq(3)
			expect(league_table.get_goals_against("Schalke 04")).to eq(13)
		end

		it "updates the results of the teams that played a match" do
			expect(league_table.get_wins("Man Utd")).to eq(1)
			expect(league_table.get_losses("Schalke 04")).to eq(1)
			expect(league_table.get_draws("Man Utd")).to eq(1)
			expect(league_table.get_draws("Schalke 04")).to eq(1)
		end
	end

	describe '#reset_standings' do
		it "clears the teams array and assigns the standings again based on the matches array" do
			league_table.matches.push("Liverpool 1 - 1 Man Utd")
			
			expect(league_table.get_points("Man Utd")).to eq(1)
			expect(league_table.get_draws("Man Utd")).to eq(1)
			
			league_table.matches.replace(["Man Utd 3 - 0 Liverpool"]) #reset_standings called

			expect(league_table.get_points("Man Utd")).to eq(3)
			expect(league_table.get_draws("Man Utd")).to eq(0)
		end
	end

	context "without any matches of a team in the matches array" do

		describe	"#get_points" do
			it "returns 0" do
				expect(league_table.get_points("Man Utd")).to eq(0)
			end
		end		

		describe	"#get_goals_for" do
			it "returns 0" do
				expect(league_table.get_goals_for("Man Utd")).to eq(0)
			end
		end	

		describe	"#get_goals_against" do
			it "returns 0" do
				expect(league_table.get_goals_against("Man Utd")).to eq(0)
			end
		end		

		describe	"#get_goal_difference" do
			it "returns 0" do
				expect(league_table.get_goal_difference("Man Utd")).to eq(0)
			end
		end	

		describe	"#get_wins" do
			it "returns 0" do
				expect(league_table.get_wins("Man Utd")).to eq(0)
			end
		end	

		describe	"#get_draws" do
			it "returns 0" do
				expect(league_table.get_draws("Man Utd")).to eq(0)
			end
		end	

		describe	"#get_losses" do
			it "returns 0" do
				expect(league_table.get_losses("Man Utd")).to eq(0)
			end
		end	

	end

	context "with matches of particular teams in the matches array" do
		
		before(:example) do
			league_table.matches.push("Man Utd 3 - 0 Liverpool")
			league_table.matches.push("Liverpool 1 - 1 Man Utd")
		end

		describe	"#get_points" do
			it "returns the no. of points a team has" do
				expect(league_table.get_points("Man Utd")).to eq(4)
				expect(league_table.get_points("Liverpool")).to eq(1)
			end
		end		

		describe	"#get_goals_for" do
			it "returns the no. of goals the team has scored" do
				expect(league_table.get_goals_for("Man Utd")).to eq(4)
				expect(league_table.get_goals_for("Liverpool")).to eq(1)
			end
		end		

		describe	"#get_goals_against" do
			it "returns the no. of goals the team has conceded" do
				expect(league_table.get_goals_against("Man Utd")).to eq(1)
				expect(league_table.get_goals_against("Liverpool")).to eq(4)
			end
		end		

		describe	"#get_goal_difference" do
			it "returns the diffrence between goals for and against" do
				expect(league_table.get_goal_difference("Man Utd")).to eq(3)
				expect(league_table.get_goal_difference("Liverpool")).to eq(-3)
			end
		end	

		describe	"#get_wins" do
			it "returns the no. of wins of the team" do
				expect(league_table.get_wins("Man Utd")).to eq(1)
				expect(league_table.get_wins("Liverpool")).to eq(0)
			end
		end	

		describe	"#get_draws" do
			it "returns the no. of draws  of the team" do
				expect(league_table.get_draws("Man Utd")).to eq(1)
				expect(league_table.get_draws("Liverpool")).to eq(1)
			end
		end	

		describe	"#get_losses" do
			it "returns the no. of losses of the team" do
				expect(league_table.get_losses("Man Utd")).to eq(0)
				expect(league_table.get_losses("Liverpool")).to eq(1)
			end
		end	

	end

end