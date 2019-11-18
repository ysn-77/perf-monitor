require 'uri'
require 'net/http'

class PerformanceTest < ApplicationRecord

  PAGE_SPEED_URL ='https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url='


  validates_presence_of :max_ttfb, :max_tti, :max_speed_index, :max_ttfp, 
                        :ttfb, :tti, :speed_index, :ttfp, :passed, :url

  validates :url, length: { maximum: 1083 }, http_url: true

  def run_tests
    results = Net::HTTP.get(URI.parse(PAGE_SPEED_URL + encoded_url))
    results = JSON.parse(results).with_indifferent_access
    
    self.ttfb = results[:lighthouseResult][:audits]['time-to-first-byte'][:numericValue].round
    self.ttfp = results[:lighthouseResult][:audits]['first-meaningful-paint'][:numericValue].round
    self.tti = results[:lighthouseResult][:audits][:interactive][:numericValue].round
    self.speed_index = results[:lighthouseResult][:audits]['speed-index'][:numericValue].round
    
    self.passed = ttfb < max_ttfb &&
      ttfb < max_tti &&
      ttfb < max_speed_index &&
      ttfb < max_ttfp
  end

  def encoded_url
    URI.encode_www_form_component url
  end
end
