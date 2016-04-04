require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  test "posting a URL to create returns a key which redirects to the original URL" do
    url = 'http://foo.com'
    key = JSON.parse((post :create, url: url).body)['key']
    assert_response :success
    get :show, key: key
    assert_redirected_to url
  end

  test "the same URL posted twice returns the same key" do
    url = 'http://foo.com'
    key1 = JSON.parse((post :create, url: url).body)['key']
    key2 = JSON.parse((post :create, url: url).body)['key']
    assert_equal key1, key2
  end
end
