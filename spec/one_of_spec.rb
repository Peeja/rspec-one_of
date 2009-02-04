$: << File.dirname(__FILE__) + "/../lib"

require 'rubygems'
require 'spec'
require 'one_of'

describe OneOf do
  include OneOf
  
  describe "should pass when as few as one element of the collection passes" do
    specify "using should =="                do one_of([1, 2, 3]).should == 2 end
    specify "using should and a matcher"     do one_of([true, nil]).should be_true end
    specify "using should_not and a matcher" do one_of([true, false]).should_not be_nil end
  end
  
  describe "should fail when no element of the collection" do
    def self.specify_failure(msg, &block)
      specify(msg) do
        # instance_eval so we don't run in the module context
        lambda { instance_eval(&block) }.
          should raise_error(Spec::Expectations::ExpectationNotMetError)
      end
    end
    
    specify_failure "using should =="                do one_of([1, 2, 3]).should == 4 end
    specify_failure "using should and a matcher"     do one_of([true, false]).should be_nil end
    specify_failure "using should_not and a matcher" do one_of([nil, nil]).should_not be_nil end
  end
end
