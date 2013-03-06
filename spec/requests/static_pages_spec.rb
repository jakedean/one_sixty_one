require 'spec_helper'

describe "StaticPages" do
  subject {page}

  describe "home page" do
    before {visit root_path}

    its(:source) { should have_selector('h1', text: '161') }
    its(:source) { should have_selector('title', text: full_title('Home')) } 
    its(:source) { should have_link('About') }

  end

  describe "about page" do
    before {visit about_path}

    its(:source) { should have_content('About') }
    its(:source) { should have_selector('title', text: full_title('About')) }
    its(:source) { should have_link('Home') }
  end  

end
