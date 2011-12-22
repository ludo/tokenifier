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
Usage: tokinifier [options] COMMAND 'custom string'

       tokinifier e|encrypt "CUSTOM DATA"
       tokinifier d|decrypt "CUSTOM DATA"

       tokinifier --secret CUSTOMSECRET e|encrypt "CUSTOM DATA"
       tokinifier --secret CUSTOMSECRET d|decrypt "ENCRYPTED DATA"

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
      unless ARGV.size == 2
        optparse.help
        exit
      end

      optparse.parse!

      puts case ARGV.first
        when /^e/
          Tokenifier.encrypt(ARGV.last, options)
        when /^d/
          Tokenifier.decrypt(ARGV.last, options)
        else
          optparse.help
          exit
      end
    end

  end
end