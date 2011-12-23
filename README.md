# Tokenifier

Tokenifier is a Gibberish gem wrapper.
It provides an approach to encrypt and decrypt structures like Numeric, String and Hash.

[![Build Status](https://secure.travis-ci.org/ludo/tokenifier.png)](http://travis-ci.org/ludo/tokenifier)


## Installation

Install the gem

    gem install tokenifier

Tokenifier will install gibberish the gem as dependency

    require "tokenifier"

Thats it.



## Rails

Put the string into Gemfile

    gem "tokenifier", "~> 0.1"

Run tokenifier:install generator

    rails g tokenifier:install

Rails generator will create config/tokenifier.yml with unique secret strings.

    development:
      secret: 7e991d82a0dd42b0afa293a339308c6f

You have to use a permanent secret string to decrypt tokens.
If no secret defined for environment Tokenifier uses random secret string each execution time.



## Usage

To encrypt data

    Tokenifier.encrypt("string")          # => "U2FsdGVkX1+YHpkTh..."
    Tokenifier.encrypt(:key => 'value')   # => "U2FsdGVkX18ts+aRd..."

To decrypt data

    Tokenifier.decrypt("U2FsdGVkX1+...")  # => "string"
    Tokenifier.decrypt("U2FsdGVkX18...")  # => {"key" => "value"}

Errors handling

    Tokenifier.encrypt(nil)               # => raises Tokenifier::Error
    Tokenifier.encrypt("")                # => raises Tokenifier::Error

    Tokenifier.decrypt("malformed hash")  # => raises Tokenifier::Error

Custom secret usage

    data = Tokenifier.encrypt("string", :secret => 'secret')
    Tokenifier.decrypt(data, :secret => 'secret')               # => "string"
    Tokenifier.decrypt(data)                                    # => raises Tokenifier::Error, "Got a malformed string"



## CLI usage

Usage:

    tokenifier [options] COMMAND 'custom string'

Commands:

    s|secret - Generates secret string
    e|encrypt - Does data encryption of any string data
    d|decrypt - Does data decryption from hashed data.

    NOTE: You have to use a permanent secret to decrypt a data.
          Tokinifier generates random secret string each execution time instead.

Examples:

     tokenifier encrypt "CUSTOM DATA"
     tokenifier decrypt "CUSTOM DATA"

     tokenifier --secret MYSECRET e "CUSTOM DATA"
     tokenifier --secret MYSECRET d "ENCRYPTED DATA"
