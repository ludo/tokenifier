require 'spec_helper'

describe Tokenifier do

  it { should respond_to(:encrypt) }
  it { should respond_to(:decrypt) }

  context "by default" do
    let(:data) { "some custom string" }
    let(:encrypted) { described_class.encrypt(data) }
    let(:decrypted) { described_class.decrypt(encrypted) }
    
    specify { decrypted.should == data }
    specify { data.should == decrypted }
  end

  context "custom secret" do
    let(:data) { "some custom string" }
    let(:secret) { "MY CUSTOM SECRET" }
    let(:encrypted) { described_class.encrypt(data, :secret => secret) }
    let(:decrypted) { described_class.decrypt(encrypted, :secret => secret) }

    specify { lambda { described_class.decrypt(encrypted) }.should raise_error(Tokenifier::Error) }
    specify { decrypted.should == data }
    specify { data.should == decrypted }
  end

end