require 'spec_helper'

describe Tokenifier::Cipher do

  subject { Class.new.extend(described_class) }

  describe ".cipher" do

    context "calling method" do
      specify { subject.cipher.should be_a(Gibberish::AES) }
      specify { subject.cipher.cipher.should be_a(OpenSSL::Cipher::Cipher) }
    end

    context "passing block" do
      specify { subject.cipher { |c| c.should_not be_nil } }
      specify { subject.cipher { |c| c.should be_a(Gibberish::AES) } }
      specify { subject.cipher { |c| c.cipher.should be_a(OpenSSL::Cipher::Cipher) } }
    end

    context "using encryption" do
      let(:cipher) { subject.cipher }
      specify { cipher.enc("string").should_not be_empty }
      specify { cipher.dec(cipher.enc("string")).should == "string" }
    end

  end

end