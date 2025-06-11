# apps/api/v2/logic/secrets/generate_secret.rb

require_relative 'base_secret_action'

module V2::Logic
  module Secrets
    class GenerateSecret < BaseSecretAction

      def process_secret
        @kind = :generate
        secret_opts = OT.conf.dig(:site, :secret_options) || {}
        min_len = secret_opts[:min_password_length] || 8
        max_len = secret_opts[:max_password_length] || 128

        length = payload.fetch(:length, 12).to_i
        length = min_len if length < min_len
        length = max_len if length > max_len
        @secret_value = Onetime::Utils.strand(length)
      end

    end
  end
end
