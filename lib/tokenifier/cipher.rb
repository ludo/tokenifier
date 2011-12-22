module Tokenifier
  module Cipher

    SECRET = '897316929176464ebc9ad085f31e7284'

    def cipher(*args, &block)
      aes = Gibberish::AES.new(args.first || SECRET)
      block_given? ? yield(aes) : aes
    end

  end
end