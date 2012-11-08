require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "Sign In Page " do
  	before { visit signin_path}

    it "should have the h1 'Sign In'" do
      should have_selector('h1', :text => 'Sign In')
	end
    
    it "should have the title 'Sign In'" do
      should have_selector('title', :text => 'Sign In')
	end

    describe "with invalid information" do
      before { click_button "Sign in" }

	  it "should have the title 'Sign In'" do
	     should have_selector('title', :text => 'Sign In')
	  end

	  it "should have the an error text 'invalid'" do
	    should have_selector('div.alert.alert-error', :text => 'Invalid')
	  end

      #describe "after visiting another page the error should go" do
      #	before { click_link "Home" }

	  #  it "should_not have the an error text 'invalid'" do
	  #    should_not have_selector('div.alert.alert-error', :text => 'Invalid')
	  #	end
      #end

   end

   describe "with valid information the test should pass" do
	    before do 
	    	@user = User.new(name: "Kumaresan", email: "kumaresan@manickavelu.com", 
				password: "foobar", password_confirmation: "foobar")
	    	@user.save
	    	fill_in "Email",    with: @user.email
	        fill_in "Password", with: @user.password
	        click_button "Sign in"
		end 

	  	it "should have the title 'User Name'" do
	     	should have_selector('title', :text => @user.name)
	  	end

	  	it "should have the signout link" do
	     	 should have_selector('a', :text => 'Sign out', :href => signout_path)
	  	end

		describe "signout should go to home page" do
			before do 
				save_and_open_page
				click_link "signout"
			end

		  	it "should have the title 'Home'" do
		     	should have_selector('title', :text => 'Home')
		  	end

		end
  	end
  end
end
