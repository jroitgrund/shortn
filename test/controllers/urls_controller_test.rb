require 'test_helper'

class UrlsControllerTest < ActionController::TestCase
  test "posting a URL to create returns a key which redirects to the original URL" do
    url = 'http://foo.com'
    key = JSON.parse((post :create, url: url).body)['key']
    assert_response :success
    get :show, key: 5
    assert_redirected_to url
  end

end
