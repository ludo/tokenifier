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

    context "custom secret" do

      context "default secret" do
        let(:first_call) { subject.cipher.password }
        let(:second_call) { subject.cipher.password }

        specify { first_call.should == second_call }
        specify { second_call.should == first_call }
      end

      context "custom secret" do
        let(:first_call) { subject.cipher("CUSTOM SECRET").password }
        let(:second_call) { subject.cipher("CUSTOM SECRET").password }
        let(:default) { subject.cipher.password }

        specify { default.should_not == second_call }
        specify { first_call.should == second_call }
        specify { second_call.should == first_call }
        specify { second_call.should == "CUSTOM SECRET" }
      end

    end

  end

  describe ".load_rails_secret" do

    let(:rails) { Class.new }

    before {
      rails.stub_chain(:root, :join).and_return(File.expand_path('../support/config/tokenifier.yml', __FILE__))
      rails.stub_chain(:logger).and_return(mock(:logger, :warn => nil))
      rails.stub(:env).and_return('test')
    }

    specify {
      with_stub_const(:Rails, rails) do
        subject.load_rails_secret.should == 'aaabbbccc'
      end
    }

    specify {
      without_const(:Rails) do
        subject.load_rails_secret.should_not == 'aaabbbccc'
      end
    }

  end

end