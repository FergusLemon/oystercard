require 'rspec/expectations'

RSpec::Matchers.define :have_constant do |const|
  match do |obj|
    obj.class.const_defined?(const)
  end
end
