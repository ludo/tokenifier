# Tokenifier

Tokenifier is a Gibberish gem wrapper.
It provides an approach to encrypt and decrypt structures like Strings, Hashes.

## Installation

Put the string into Gemfile

    gem "tokenifier"

Add config/tokenifier.yml in rails application

    development:
      secret: 7e991d82a0dd42b0afa293a339308c6f

## Usage

To encrypt data into hash

    Tokenifier.encrypt("string")          # => 
    Tokenifier.encrypt(:key => 'value')   # => 

To decrypt data into hash

    Tokenifier.decrypt(" ...")            # => 
    Tokenifier.decrypt(" ...")            # => 

Errors handling

    Tokenifier.encrypt(nil)               # => raises Tokenifier::Error
    Tokenifier.encrypt("")                # => raises Tokenifier::Error

    Tokenifier.decrypt("malformed hash")  # => raises Tokenifier::Error

Using custom secret

    data = Tokenifier.encrypt("string", :secret => 'secret')
    Tokenifier.decrypt(data, :secret => 'secret')               # => "string"
    Tokenifier.decrypt(data)                                    # => raises Tokenifier::Error, "Got a malformed string"

## CLI usage

To generate client token

    tokenifier string "some-identy-string" [--secret=OPTIONAL_SECRET_STRING]



