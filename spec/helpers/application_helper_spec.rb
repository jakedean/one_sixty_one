require 'spec_helper'

describe ApplicationHelper do 

	describe "full title helper" do
		it " should include this full title" do
			full_title('foo').should =~ /foo/
		end

		it "should not include this full title" do
			full_title('').should =~ /^One Sixty One/
		end
	    it "should not include the bar with a blank" do
	    	full_title('').should_not =~ /\|/
	    end
	end
	
end