class SeedController < ActionController::API # ApplicationController
  def create
    seed = Seed.instance(params.permit(:phrase)[:phrase])
    render json: {
             message: :ok,
             seed_phrase: seed&.phrase
           },
      status: :created
  end
end
