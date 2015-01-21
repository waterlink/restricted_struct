class RestrictedStruct < Struct
  ACCESS_RESTRICTIONS = {
    private: ->(methods) { ->(_) { private *methods } },
    protected: ->(methods) { -> (_) { protected *methods } }
  }
  ACCESS_LEVELS = ACCESS_RESTRICTIONS.keys

  class << self
    def new(access_level, *properties)
      super(*properties, &access_restriction(access_level, properties))
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
end
