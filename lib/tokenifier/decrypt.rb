module Tokenifier
  module Decrypt

    # data marshaling differs depending to ruby version
    # so its better to pack hash into string accoring to some rule
    def unpack_string(data)
      case data
        when /[\:(\#)?]/
          hsh = data.split('#').map {|s| s.split(':')}.inject({}) {|c, (k, v)| c.merge({k => v})}
          hsh.respond_to?(:with_indifferent_access) ? hsh.with_indifferent_access : hsh
        else
          data
      end
    end

    def decrypt(token, options = {})

      raise Error, "Encrypted data should be a String" unless token.is_a?(String)
      raise Error, "Got an incomlete encrypted string" if token.size < 12

      cipher(options[:secret]) do |c|
        unpack_string(c.dec(token))
      end

    rescue OpenSSL::Cipher::CipherError => e
      raise Error, "Got a malformed string"
    end

  end
end