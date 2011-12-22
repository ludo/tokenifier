module Tokenifier
  module Cipher

    def secret
      @secret ||= Tokenifier::Rails.secret || Tokenifier::Random.secret
    end

    def cipher(*args, &block)
      aes = Gibberish::AES.new(args.first || secret)
      block_given? ? yield(aes) : aes
    end

  end
end