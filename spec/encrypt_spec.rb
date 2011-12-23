require 'spec_helper'

describe Tokenifier::Encrypt do

  subject { Class.new.extend(described_class) }

  describe "#pack_hash" do

    let(:packed) { subject.pack_hash(hsh) }

    context "empty hash" do
      let(:hsh) { {} }
      let(:expected) { "" }
      specify { packed.should == expected }
    end

    context "one key-value pair" do
      let(:hsh) { {:a => 2} }
      let(:expected) { "a:2" }
      specify { packed.should == expected }
    end

    context "a few key-value pairs" do
      let(:hsh) { {:a => 2, :b => 'string 123', :c => true} }
      let(:expected) { "a:2#b:string 123#c:true" }
      specify { packed.should == expected }
    end

    context "we are not supporting nested hashes yet due simplicity of solution" do
      pending
    end

  end

  describe ".encrypt" do

    let(:cipher) { Proc.new{|*args, &block| yield(*args) } }

    context "exception handing" do
      before {
        cipher.stub(:enc).and_return("some output")
        subject.stub(:cipher).and_yield(cipher)
      }

      specify { lambda { subject.encrypt(nil) }.should raise_error(Tokenifier::Error) }
      specify { lambda { subject.encrypt("") }.should  raise_error(Tokenifier::Error) }
      specify { lambda { subject.encrypt({}) }.should  raise_error(Tokenifier::Error) }
      specify { lambda { subject.encrypt(123) }.should_not  raise_error }
      specify { lambda { subject.encrypt(1.1) }.should_not  raise_error }
      specify { lambda { subject.encrypt("1") }.should_not  raise_error }
      specify { lambda { subject.encrypt(:a => "1") }.should_not  raise_error }
    end

    context "data types" do

      before {
        subject.should_receive(:cipher).and_yield(cipher)
      }

      context "Numeric" do
        before { cipher.should_receive(:enc).with("1").and_return("test output = 1") }
        specify { subject.encrypt(1).should == "test output = 1" }
      end

      context "String" do
        before { cipher.should_receive(:enc).with("value").and_return("test output = value") }
        specify { subject.encrypt("value").should == "test output = value" }
      end

      context "Hash" do
        before { cipher.should_receive(:enc).with("a:1234").and_return("test output = a:1234") }
        specify { subject.encrypt(:a => 1234).should == "test output = a:1234" }
      end

    end

  end

  describe ".key" do
    context "should be symetric" do
      let(:first) { subject.key(:username => 'test', :password => 'test', :salt => 'aaaabbbb') }
      let(:second) { subject.key(:username => 'test', :password => 'test', :salt => 'aaaabbbb') }

      specify { first.should == second }
      specify { second.should == first }
    end

    context "should use delimeter" do
      let(:first) { subject.key(:username => 'test', :password => 'test', :delimeter => '$') }
      let(:second) { subject.key(:username => 'test', :password => 'test', :delimeter => '#') }

      specify { first.should_not == second }
      specify { second.should_not == first }
    end
  end

end