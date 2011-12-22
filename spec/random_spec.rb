require 'spec_helper'

describe Tokenifier::Random do

  subject { described_class }

  describe ".secret" do
    its(:secret) { should_not be_nil }
    its(:secret) { should be_a(String) }
    its(:secret) { should_not == "" }

    context "uniqness" do
      let(:first) { described_class.secret }
      let(:second) { described_class.secret }

      specify { first.should_not == second }
      specify { second.should_not == first }
    end

  end
end