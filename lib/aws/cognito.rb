# frozen_string_literal: true

module Aws
  AuthFlows = {
    USER_PASSWORD_AUTH: 'USER_PASSWORD_AUTH'
  }.freeze

  class Cognito
    def initialize
      @client = ::Aws::CognitoIdentityProvider::Client.new
    end

    def initiate_auth(**auth_params)
      pool_params = Rails.application.credentials[:aws][:cognito][:"demo-1-user-pool"]

      @client.initiate_auth({
                              auth_flow: AuthFlows[:USER_PASSWORD_AUTH],
                              client_id: pool_params[:client_id],
                              auth_parameters: { USERNAME: auth_params[:username], PASSWORD: auth_params[:password] }
                            })
    end
  end
end
