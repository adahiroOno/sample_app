require 'spec_helper'

describe "User pages" do#User pages
   describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
     describe "page" do#page
       it { should have_selector('h1',    text: "Update your profile") }
       it { should have_selector('title', text: "Edit user") }
       it { should have_link('change', href: 'http://gravatar.com/emails') }
     end#page
      describe "with invalid information" do#with invalid information
        before { click_button "Save changes" }

        it { should have_content('error') }
      end#with invalid information

     describe "with valid information" do#with valid information
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do#before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end#before do

      it { should have_selector('title', text: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end#with valid information
  end#edit
end#User pages