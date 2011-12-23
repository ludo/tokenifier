require 'yaml'

module Tokenifier
  module Cipher

    def secret
      @secret ||= load_rails_secret
      @secret ||= Tokenifier::Random.secret
      @secret
    end

    def cipher(*args, &block)
      aes = Gibberish::AES.new(args.first || secret)
      block_given? ? yield(aes) : aes
    end

    def load_rails_secret
      return unless defined?(Rails)

      filename = Rails.root.join('config', 'tokenifier.yml')

      if File.exists?(filename)
        config = YAML.load(
          ERB.new(
            IO.read(filename)
          ).result
        )[Rails.env]

        @secret = config['secret']
      else
        @secret = Tokenifier::Random.secret

        Rails.logger.warn "*** Tokenifier warning:"
        Rails.logger.warn "*** Config tokenifier.yml file not found."
        Rails.logger.warn "*** Run rails g tokenifier:install to generate one"
        Rails.logger.warn "*** Using secret: #{@secret}"
      end

      @secret
    end

  end
end