RSpec.describe RestrictedStruct do
  it "validates access_level" do
    expect {
      described_class.new(:invalid, :some, :properties)
    }.to raise_error(ArgumentError)
  end

  described_class::ACCESS_LEVELS.each do |access_level|
    context "when creating #{access_level} struct" do
      subject { described_class.new(access_level, :some, :properties) }

      it "makes readers #{access_level}" do
        expect {
          subject.new("some", "value").some
        }.to raise_error(NoMethodError, /#{access_level} method `some'/)
      end

      it "makes writers #{access_level}" do
        expect {
          subject.new("some", "value").properties = 42
        }.to raise_error(NoMethodError, /#{access_level} method `properties='/)
      end
    end

  end
end
