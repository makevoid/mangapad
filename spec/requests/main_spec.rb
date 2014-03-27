require 'spec_helper'

describe "Main" do
  describe "GET /" do
    it "shows the main page" do
      visit "/"
      page.body.should =~ /mangapad/i
    end
  end
end
