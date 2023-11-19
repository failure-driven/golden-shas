class CalculateGoldenShaJob < ApplicationJob
  queue_as :default

  GOLDEN_SHA = "00000".freeze

  def perform(index, previous_hash, timestamp, data)
    nonce = -1
    hash = ""
    until hash.slice(0, GOLDEN_SHA.length) == GOLDEN_SHA
      nonce += 1
      hash = Digest::SHA2.hexdigest(
        index.to_s + previous_hash.to_s + timestamp.to_s + data + nonce.to_s
      )
    end
    # [nonce, hash]
    # TODO: wirte to db:
    #       BlockChain.create!(index, hash, timestamp, data, nonce)
    Rails.logger.warn([nonce, hash])
  end
end
