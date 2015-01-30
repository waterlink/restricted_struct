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

  describe "keyword arguments" do
    let(:rectangle) { RestrictedStruct.new(:protected, :x1, :y1, :x2, :y2, :color => :white) }

    it "equals to specified default if omitted" do
      expect(rectangle.new(1, 2, 3, 4)).to eq(rectangle.new(1, 2, 3, 4, :white))
    end

    it "can be overriden by specifying as normal argument" do
      expect(rectangle.new(1, 2, 3, 4, :red)).not_to eq(rectangle.new(1, 2, 3, 4))
    end

    it "can be overriden by specifying as keyword argument" do
      expect(rectangle.new(1, 2, 3, 4, :color => :red)).not_to eq(rectangle.new(1, 2, 3, 4))
    end

    it "being specified as keyword argument is equivalent to specifying as normal argument" do
      expect(rectangle.new(1, 2, 3, 4, :red)).to eq(rectangle.new(1, 2, 3, 4, :color => :red))
    end

    it "can be used instead of normal arguments" do
      expect(rectangle.new(1, 2, :x2 => 3, :y2 => 4)).to eq(rectangle.new(1, 2, 3, 4))
    end

    it "overrides value of normal argument" do
      expect(rectangle.new(1, 2, 3, 4, :x2 => 5)).to eq(rectangle.new(1, 2, 5, 4))
    end
  end
end
