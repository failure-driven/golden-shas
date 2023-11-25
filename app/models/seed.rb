class Seed < ApplicationRecord
  def self.instance(phrase = nil)
    find_by(id: true) || phrase && create!(id: true, phrase: phrase)
  end
end
