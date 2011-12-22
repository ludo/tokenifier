require 'optparse'

module Tokenifier
  module Cli
    extend self

    def options
      @options ||= {}
    end

    def optparse
      OptionParser.new do |opts|
        opts.banner =<<-USAGE

Usage:

        tokenifier [options] COMMAND 'custom string'

Commands:

        s|secret - Generates secret string
        e|encrypt - Does data encryption of any string data
        d|decrypt - Does data decryption from hashed data.

        NOTE: You have to use permanent secret to decryption data.
              Tokinifier generates dafult secret each execution time.

Examples:

        tokenifier encrypt "CUSTOM DATA"
        tokenifier decrypt "CUSTOM DATA"

        tokenifier --secret MYSECRET e "CUSTOM DATA"
        tokenifier --secret MYSECRET d "ENCRYPTED DATA"


USAGE

        opts.on('-s', '--secret SECRET', 'Using custom secret phrase') do |secret|
          options[:secret] = secret
        end

        opts.on('-h', '--help', 'Display this screen') do
          puts opts
          exit
        end
      end
    end

    def run
      optparse.parse!

      begin
        case ARGV.first
          when /^e/
            if options[:secret].nil?
              options[:secret] = Tokenifier::Random.secret
              puts "SECRET: #{options[:secret]}"
            end

            puts Tokenifier.encrypt(ARGV.last, options)
          when /^d/
            puts Tokenifier.decrypt(ARGV.last, options)
          when /^s/
            puts Tokenifier::Random.secret
          else
            puts optparse.help
            exit
        end
      rescue Tokenifier::Error => e
        puts "ERROR: Token processing error."
        puts optparse.help
        exit
      end

    end

  end
end