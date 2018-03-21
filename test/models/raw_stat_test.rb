require 'test_helper'

class RawStatTest < ActiveSupport::TestCase

  def setup
    @rawstat = raw_stats(:valid)
    @rawstatnew = RawStat.create(height: 57, weight: 140, dog_count: 1, cat_count: 0)
  end

  test 'valid stats' do
    assert @rawstat.valid?
  end

  test 'invalid without height' do
    @rawstat.height = nil
    refute @rawstat.valid?, 'rawstat is invalid without a height'
    assert_not_nil @rawstat.errors[:height], 'no validation error for height present'
  end

  test 'invalid without weight' do
    @rawstat.weight = nil
    refute @rawstat.valid?, 'rawstat is invalid without a weight'
    assert_not_nil @rawstat.errors[:weight], 'no validation error for weight present'
  end

  test 'invalid without dog_count' do
    @rawstat.dog_count = nil
    refute @rawstat.valid?, 'rawstat is invalid without a dog_count'
    assert_not_nil @rawstat.errors[:dog_count], 'no validation error for dog_count present'
  end

  test 'invalid without cat_count' do
    @rawstat.cat_count = nil
    refute @rawstat.valid?, 'rawstat is invalid without a cat_count'
    assert_not_nil @rawstat.errors[:cat_count], 'no validation error for cat_count present'
  end    

  test 'create and retrieve rawstat' do
    assert_not_nil @rawstatnew.errors[:id], 'rawstatnew data not saved'
  end

  test 'retrieve new rawstat record' do
    newrawstat = RawStat.find(@rawstatnew[:id])
    assert_equal newrawstat[:id], @rawstatnew[:id], 'newrawstat id does not match'
  end

end
