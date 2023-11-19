class SeedController < ActionController::API # ApplicationController
  def create
    seed = Seed.instance(params.permit(:phrase)[:phrase])
    if seed
      CalculateGoldenShaJob.perform_later(
        0,
        "0",
        (Time.zone.now.beginning_of_minute + 1.minute).to_i,
        seed.phrase
      )
    end
    render json: {
             message: :ok,
             seed_phrase: seed&.phrase
           },
      status: :created
  end
end
