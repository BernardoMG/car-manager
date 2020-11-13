require 'test_helper'

# Related to ModelColor model
# Mostly to ensure that each validation works as expected
class ModelColorTest < ActiveSupport::TestCase
  test 'should save association without errors' do
    association = model_colors(:simple_association)

    assert association.save
  end
end
