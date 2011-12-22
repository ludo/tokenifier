module Tokenifier
  module Encrypt

    # data marshaling differs depending to ruby version
    # so its better to pack hash into string accoring to some rule
    def pack_hash(hsh)
      hsh.map { |v| v.join(':') }.join('#')
    end

    def encrypt(data, options = {})

      raise Tokenifier::Error, "DATA should not be empty" if data.blank?

      # cipher(options[:secret]).do |c|
      #   c.enc(data.is_a?(Hash) ? pack_hash(data) : data.to_s)
      # end

    end

  end
end