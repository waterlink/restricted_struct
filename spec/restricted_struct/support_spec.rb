RSpec.describe RestrictedStruct::Support do
  describe ".extract_keyword_args" do
    it "splits into list and last parameter if it is a hash" do
      expect(described_class.extract_keyword_args(
        [1, 2, 3, { :color => :red }]
      )).to eq([[1, 2, 3], { :color => :red }])
    end

    it "last parameter defaults to an empty hash" do
      expect(described_class.extract_keyword_args(
        [1, 2, 3, 4]
      )).to eq([[1, 2, 3, 4], {}])
    end

    it "list defaults to an empty list if only hash provided" do
      expect(described_class.extract_keyword_args(
        [{ :color => :red }]
      )).to eq([[], { :color => :red }])
    end

    it "returns empty list and hash if provided array is empty" do
      expect(described_class.extract_keyword_args([])).to eq([[], {}])
    end
  end
end
