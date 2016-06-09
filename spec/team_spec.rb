require 'spec_helper'

RSpec.describe Team do

	let!(:team) { Team.new("Liverpool") }

	describe "#name" do
		it "returns the name of the team" do
			expect(team.name).to eq("Liverpool")
		end
	end
	
	context "when the team is a new team without any matches played" do
		describe "#points" do
			it "returns 0" do
				expect(team.points).to eq(0)
			end
		end
		describe "#wins" do
			it "returns 0" do
				expect(team.wins).to eq(0)
			end
		end
		describe "#draws" do
			it "returns 0" do
				expect(team.draws).to eq(0)
			end
		end
		describe "#losses" do
			it "returns 0" do
				expect(team.losses).to eq(0)
			end
		end
		describe "#goals_for" do
			it "returns 0" do
				expect(team.goals_for).to eq(0)
			end
		end
		describe "#goals_against" do
			it "returns 0" do
				expect(team.goals_against).to eq(0)
			end
		end
		describe "#goal_difference" do
			it "returns 0" do
				expect(team.goal_difference).to eq(0)
			end
		end
	end

	context "when the team played some matches" do

		before(:each) do
			team.win(4, 1)
			team.win(2, 0)
			team.lose(1, 3)
			team.draw(2, 2)
		end

		describe "#points" do
			it "returns the proper number of points of the team" do
				expect(team.points).to eq(7)
			end
		end
		describe "#wins" do
			it "it returns the proper number of wins of the team" do
				expect(team.wins).to eq(2)
			end
		end
		describe "#draws" do
			it "it returns the proper number of draws of the team" do
				expect(team.draws).to eq(1)
			end
		end
		describe "#losses" do
			it "it returns the proper number of loses of the team" do
				expect(team.losses).to eq(1)
			end
		end
		describe "#goals_for" do
			it "it returns the proper number of goals scored by the team" do
				expect(team.goals_for).to eq(9)
			end
		end
		describe "#goals_against" do
			it "it returns the proper number of goals conceded by the team" do
				expect(team.goals_against).to eq(6)
			end
		end
		describe "#goal_difference" do
			it "it returns the proper goal difference for the team" do
				expect(team.goal_difference).to eq(3)
			end
		end
	end

	describe "#win" do
		it "updates the points of the team by 3" do
			expect { team.win(2, 1) }.to change(team, :points).by(3)
		end
		it "updates the nr of wins of the team" do
			expect { team.win(2, 1) }.to change(team, :wins).by(1)
		end
		it "updates the goals_for of the team" do
			expect { team.win(2, 1) }.to change(team, :goals_for).by(2)
		end
		it "updates the goals_agains the team" do
			expect { team.win(2, 1) }.to change(team, :goals_against).by(1)
		end
		it "does not change the losses or draws of the team" do
			expect { team.win(2, 1) }.not_to change(team, :losses)
			expect { team.win(2, 1) }.not_to change(team, :draws)
		end
	end

	describe "#draw" do
		it "updates the points of the team by 1" do
			expect { team.draw(1, 1) }.to change(team, :points).by(1)
		end
		it "updates the nr of draws of the team" do
			expect { team.draw(1, 1) }.to change(team, :draws).by(1)
		end
		it "updates the goals_for of the team" do
			expect { team.draw(1, 1) }.to change(team, :goals_for).by(1)
		end
		it "updates the goals_agains the team" do
			expect { team.draw(1, 1) }.to change(team, :goals_against).by(1)
		end
		it "does not change the losses or draws of the team" do
			expect { team.draw(1, 1) }.not_to change(team, :losses)
			expect { team.draw(1, 1) }.not_to change(team, :wins)
		end
	end

	describe "#lose" do
		it "does not change the team points" do
			expect { team.lose(1, 3) }.not_to change(team, :points)
		end
		it "updates the nr of losses of the team" do
			expect { team.lose(1, 3) }.to change(team, :losses).by(1)
		end
		it "updates the goals_for of the team" do
			expect { team.lose(1, 3) }.to change(team, :goals_for).by(1)
		end
		it "updates the goals_agains the team" do
			expect { team.lose(1, 3) }.to change(team, :goals_against).by(3)
		end
		it "does not change the losses or draws of the team" do
			expect { team.lose(1, 3) }.not_to change(team, :draws)
			expect { team.lose(1, 3) }.not_to change(team, :wins)
		end
	end

end
	