require 'spec_helper'

describe "User Pages" do

	subject { page }

	describe "signup pages" do
		before { visit signup_path }

	    it "should have the h1 'Sign up'" do
	      should have_selector('h1', :text => 'Sign Up')
    	end
	    it "should have the title 'Sign up'" do
	      should have_selector('title', :text => 'Sign Up')
    	end


	   	describe "with invalid information" do
	   	  let(:submit) { "Create my account" }
	      it "should not create a user" do
	        expect { click_button submit }.not_to change(User, :count)
	      end
	    end


	   	describe "with valid information" do
	   	  let(:submit) { "Create my account" }
	      before do
	        fill_in "Name",         with: "Example User"
	        fill_in "Email",        with: "user@example.com"
	        fill_in "Password",     with: "foobar"
	        fill_in "Confirmation", with: "foobar"
	      end

	      it "should create a user" do
	        expect { click_button submit }.to change(User, :count).by(1)
	      end
	    end
    end



	describe "profile page" do
		before do
			@user = User.new(name: "Kumaresan", email: "kumaresan@manickavelu.com", 
				password: "foobar", password_confirmation: "foobar")

			@user.save

		#let(:user) { User.new (name: "kumaresan", email: "kumaresan@manickavelu.com", 
		#		password: "foo", password_confirmation: "foo")}

			visit user_path(@user.id) 
		end


    	it "should have the h1 'User Name'" do
	      should have_selector('h1', :text => @user.name)
		end
	    it "should have the title 'User Name'" do
	      should have_selector('title', :text => @user.name)
		end
	end


end