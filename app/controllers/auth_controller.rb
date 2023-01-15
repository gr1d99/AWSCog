# frozen_string_literal: true

require './lib/aws/cognito'

class AuthController < ApplicationController
  def create
    @cognito = Aws::Cognito.new
    @auth = @cognito.initiate_auth username: create_params[:username], password: create_params[:password]

    render json: @auth.authentication_result, status: :ok
  rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException => e
    render json: { message: e.message }, status: :unauthorized
  end

  private

  def create_params
    params.require(:auth).permit(:username, :password)
  end
end
