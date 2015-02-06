class RestrictedStruct < Struct
  ACCESS_RESTRICTIONS = {
    :private => lambda { |methods| lambda { |*| private *methods } },
    :protected => lambda { |methods| lambda { |*| protected *methods } }
  }
  ACCESS_LEVELS = ACCESS_RESTRICTIONS.keys

  class << self
    def new(access_level, *properties)
      properties, defaults = Support.extract_keyword_args(properties)
      properties.concat(defaults.keys)
      super(*properties, &access_restriction(access_level, properties)).with_defaults(defaults)
    end

    def defaults
      @defaults ||= {}
    end

    protected

    def with_defaults(defaults)
      @defaults = defaults
      self
    end

    private

    def access_restriction(access_level, properties)
      builder_strategy(access_level).call(accessor_methods(properties))
    end

    def builder_strategy(access_level)
      ACCESS_RESTRICTIONS.fetch(access_level) do
        raise ArgumentError, "access_level can be only one of #{ACCESS_LEVELS}"
      end
    end

    def accessor_methods(properties)
      properties + properties.map { |name| :"#{name}=" }
    end
  end

  def initialize(*values)
    values, keyword_args = Support.extract_keyword_args(values)
    members.each_with_index do |name, index|
      # 1.8 compatibility
      key = name.to_sym
      values[index] = self.class.defaults[key] if nil == values[index]
      values[index] = keyword_args[key] if keyword_args.has_key?(key)
    end
    super(*values)
  end
end
