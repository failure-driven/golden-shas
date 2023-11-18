# frozen_string_literal: true

require "rails_helper"

feature "It works root rails demo page", :js do
  let(:it_works_root) { ItWorksRoot.new }

  scenario "I have rails", :aggregate_failures do
    When "user visits the app" do
      it_works_root.load
    end

    Then "user sees they are on rails" do
      expect(it_works_root.rails_version.text).to match(/7.1.1/)
      expect(it_works_root.ruby_version.text).to match(/ruby 3.2.2/)
    end
  end
end
