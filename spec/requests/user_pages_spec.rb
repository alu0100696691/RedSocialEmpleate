require 'spec_helper'

describe "User pages" do

  subject { page }

  	describe "Pagina Registro" do
    		before { visit signup_path }

    			it { should have_content('Registro') }
    			it { should have_title(full_title('Registro')) }
  	end

	describe "profile page" do
  		# Replace with code to make a user variable
  		before { visit user_path(user) }

  			it { should have_content(user.name) }
  			it { should have_title(user.name) }
	end


end