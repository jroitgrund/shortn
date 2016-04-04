class UrlsController < ApplicationController

  URLS_CACHE_PREFIX = 'urls_cache'
  KEYS_CACHE_PREFIX = 'keys_cache'
  SEPARATOR = '.'

  def index
  end

  def create
    url_cache_key = "#{URLS_CACHE_PREFIX}#{SEPARATOR}#{params[:url]}"
    print params
    key = Rails.cache.read url_cache_key
    if key.nil?
      key = (0...10).map { (65 + rand(26)).chr }.join
      Rails.cache.write url_cache_key, key
      Rails.cache.write "#{KEYS_CACHE_PREFIX}#{SEPARATOR}#{key}", params[:url]
    end
    render json: {key: key}
  end

  def show
    url = Rails.cache.read "#{KEYS_CACHE_PREFIX}#{SEPARATOR}#{params[:key]}"
    if url.nil?
      raise ActionController::RoutingError.new('Not Found')
    else
      redirect_to url
    end
  end
end
