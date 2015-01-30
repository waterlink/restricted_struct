module RestrictedStruct::Support
  class << self
    def extract_keyword_args(array)
      array = array.dup
      keyword_args = Hash === array[-1] ? array.pop : {}
      [array, keyword_args]
    end
  end
end
