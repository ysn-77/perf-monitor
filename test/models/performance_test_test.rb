require 'test_helper'

class PerformanceTestTest < ActiveSupport::TestCase
  test "should not be valid without attributes" do
    performance_test = PerformanceTest.new
    assert_not performance_test.valid?
  end

  test "should only be valid with correct urls" do
    performance_test = performance_tests(:test_1)
    assert performance_test.valid?

    incorrect_urls = [
      'adsf',
      'http:// shouldfail.com',
      ':// should fail',
      '',
      'http://foo.bar/foo(bar)baz quux',
      'ftp://foo.bar/',
    ]

    correct_urls = [
      'http://142.42.1.1:8080/',
      'http://foo.com/blah_(wikipedia)#cite-1',
      'http://foo.com/blah_(wikipedia)_blah#cite-1',
      'http://foo.com/(something)?after=parens'
    ]

    incorrect_urls.each do |url|
      performance_test.url = url
      assert_not performance_test.valid?, "'#{url}' was considered as a valid url"
    end

    correct_urls.each do |url|
      performance_test.url = url
      assert performance_test.valid?, "'#{url}' was considered as an invalid url"
    end
  end

 
end
