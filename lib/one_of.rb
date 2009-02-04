module OneOf
  class OneOfDecorator
    def initialize(collection)
      @collection = collection
    end

    def should(matcher=nil)
      if matcher.nil?
        self
      else
        match = @collection.find { |e| matcher.matches?(e) }
        unless match
          raise Spec::Expectations::ExpectationNotMetError, "expected at least one element to match, but none did (eg. #{matcher.failure_message})"
        end
      end
    end
    
    def should_not(matcher)
      match = @collection.find { |e| !matcher.matches?(e) }
      unless match
        raise Spec::Expectations::ExpectationNotMetError, "expected at least one element not to match, but all did (eg. #{matcher.negative_failure_message})"
      end
    end
    
    def ==(expected)
      match = @collection.find { |e| e == expected }
      unless match
        raise Spec::Expectations::ExpectationNotMetError,
          "expected at least one element to be #{expected.inspect}, none was (using ==).  Got: #{@collection.inspect}"
      end
    end
  end

  def one_of(things)
    OneOfDecorator.new(things)
  end
  alias_method :one_of_the, :one_of
end
