module Tokenifier
  module Encrypt

    # data marshaling differs depending to ruby version
    # so its better to pack hash into string accoring to some rule
    def pack_hash(hsh, delimeter = '#')
      hsh.map { |v| v.join(':') }.join(delimeter)
    end

    def encrypt(data, options = {})

      raise Tokenifier::Error, "DATA should not be nil" if data.nil?
      raise Tokenifier::Error, "DATA should not be empty" if data.respond_to?(:empty?) && data.empty?

      cipher(options[:secret]) do |c|
        c.enc(data.is_a?(Hash) ? pack_hash(data) : data.to_s).gsub(/\n/, '')
      end
    end

    def key(data = {})
      delimeter = data[:delimeter] || "##"
      Gibberish::SHA256(pack_hash(data, delimeter))
    end

  end
end