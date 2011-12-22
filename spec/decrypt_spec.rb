require 'spec_helper'

describe Tokenifier::Decrypt do

  subject { Class.new.extend(described_class) }

  describe ".unpack_string" do

    let(:unpacked) { subject.unpack_string(data) }

    context "empty string" do
      let(:data) { "" }
      specify { unpacked.should == "" }
    end

    context "contains numeric value or string" do
      let(:data) { "12345" }
      specify { unpacked.should == "12345" }
    end

    context "contans packed hash" do
      let(:data) { "a:1234567#d:d f#c:1.2.3" }
      specify { unpacked.should == { "a" => "1234567", "c" => "1.2.3", "d" => "d f" } }
    end

    context "with_indifferent_access" do
      let(:data) { "a:1234567#d:d f#c:1.2.3" }
      let(:active_supported_hash) { mock(:active_supported_hash, :with_indifferent_access => "active_supported_hash") }
      before { data.stub_chain(:split, :map, :inject).and_return(active_supported_hash) }
      specify { unpacked.should == "active_supported_hash" }
    end

  end

  describe ".decrypt" do

    let(:cipher) { Proc.new{|*args, &block| yield(*args) } }

    context "exception handing" do
      before {
        cipher.stub(:dec).and_return("some output")
        subject.stub(:cipher).and_yield(cipher)
      }

      specify { lambda { subject.decrypt(nil) }.should raise_error(Tokenifier::Error) }
      specify { lambda { subject.decrypt("") }.should  raise_error(Tokenifier::Error) }

    end

    context "data types" do

      before {
        cipher.should_receive(:dec).and_return(data)
        subject.should_receive(:cipher).and_yield(cipher)
      }

      context "String or Numeric" do
        let(:data) { "123456789097" }
        specify { subject.decrypt(data).should == "123456789097" }
      end

      context "Packed Hash" do
        let(:data) { "a:123456789097#b:kjjdfr" }
        specify { subject.decrypt(data).should == {"a" => "123456789097", "b" => "kjjdfr"} }
      end

    end

  end

end