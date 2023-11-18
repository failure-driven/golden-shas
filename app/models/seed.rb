class Seed < ApplicationRecord
  def self.instance(phrase = nil)
    find_by(id: 1) || phrase && create!(id: 1, phrase: phrase)
  end
end
