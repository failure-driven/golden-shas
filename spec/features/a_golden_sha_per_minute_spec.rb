# frozen_string_literal: true

require "rails_helper"

feature "A golden sha is generated every minute", :js do
  let(:root) { Root.new }

  scenario "bootstrapping a newly created app" do
    Given "the app is running and has no seed phrase" do
      root.load do |page|
        expect(page.seed_phrase.value).to eq ""
      end
    end

    When "the seed phrase 'you are on rails' is entered" do
      root.when_loaded do |page|
        page.seed_phrase.set("you are on rails")
        page.seed_phrase.send_keys :tab
        expect(page.seed_phrase.value).to eq "you are on rails"
      end
    end

    Then "a job is created"
    When "the next minute passes"
    Then "a golden sha 🏆🔐 is displayed"
    And "a cirtification image is generated"
    And "another job is created to generate the next golden sha 🏆🔐"
    When "the next minute passes"
    Then "the second golden sha 🏆🔐 is displayed"
    And "another job is created to generate the next golden sha 🏆🔐"
  end
end
