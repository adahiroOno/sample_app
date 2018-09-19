require 'spec_helper'

describe "Authentication" do#1
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
  end
  subject { page }

  describe "signin page" do#2
    before { visit signin_path }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }
  end#2
      describe "signin" do#3
       before { visit signin_path }

         describe "with invalid information" do#4
           before { click_button "Sign in" }

           it { should have_selector('title', text: 'Sign in') }
           it { should have_selector('div.alert.alert-error', text: 'Invalid') }
         end#4  
        describe "with valid information" do#5
         let(:user) { FactoryGirl.create(:user) }
           before { sign_in user }
     
           it { should have_selector('title', text: user.name) }
           it { should have_link('Profile',  href: user_path(user)) }
           it { should have_link('Settings', href: edit_user_path(user)) }
           it { should have_link('Sign out', href: signout_path) }
           it { should_not have_link('Sign in', href: signin_path) }         
          before do#6
           fill_in "Email",    with: user.email.upcase
           fill_in "Password", with: user.password
           click_button "Sign in"
        end#6

         #it { should have_selector('title', text: user.name) }
         #it { should have_link('Profile', href: user_path(user)) }
         #it { should have_link('Sign out', href: signout_path) }
         #it { should_not have_link('Sign in', href: signin_path) }

              describe "followed by signout" do#7
               before { click_link "Sign out" }
                it { should have_link('Sign in') }
               end#7
        end#5
     end#3 

end#1