# frozen_string_literal: true

require "rails_helper"

feature "A golden sha is generated every minute", :js do
  include ActiveJob::TestHelper

  let(:root) { Root.new }

  scenario "bootstrapping a newly created app" do
    Given "the app is running and has no seed phrase" do
      root.load do |page|
        expect(page.seed_phrase.value).to eq ""
      end
    end

    When "the seed phrase 'you are on rails' is entered" do
      assert_enqueued_jobs 0
      assert_performed_jobs 0
      root.when_loaded do |page|
        page.seed_phrase.set("you are on rails")
        page.seed_phrase.send_keys :tab
        expect(page.seed_phrase.value).to eq "you are on rails"
      end
    end

    And "the phrase is confirmed" do
      root.when_loaded do |page|
        SitePrism::Waiter.wait_until_true {
          !page.loading.visible?
        }
        expect(page.loading).not_to be_visible
      end
    end

    Then "a job is created" do
      assert_enqueued_jobs 1
    end

    When "the next minute passes"
    Then "a golden sha 🏆🔐 is displayed"
    And "a cirtification image is generated"
    And "another job is created to generate the next golden sha 🏆🔐"
    When "the next minute passes"
    Then "the second golden sha 🏆🔐 is displayed"
    And "another job is created to generate the next golden sha 🏆🔐"
  end
end
