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
      let(:expected) { "c:true#a:2#b:string 123" }
      specify { packed.should == expected }
    end

    context "we are not supporting nested hashes yet due simplicity of solution" do
      let(:hsh) { {:a => 2, :b => 'string 123', :sub => { :a => 33 } } }
      let(:expected) { "sub:a33#a:2#b:string 123" }
      specify { packed.should == expected }
    end

  end

end