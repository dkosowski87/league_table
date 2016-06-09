require 'spec_helper'

RSpec.describe MatchTable do

	let!(:league_table) { LeagueTable.new }
	let!(:match_table) { MatchTable.new(league_table) }

	describe '#initialize' do
		it "creates a new instance of MatchTable which is a subclass of Array" do
			expect(match_table).to be_an_instance_of(MatchTable)
			expect(match_table).to be_a_kind_of(Array)
		end
	end

end