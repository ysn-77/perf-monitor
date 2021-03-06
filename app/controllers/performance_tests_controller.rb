class PerformanceTestsController < ApplicationController

  def create
    performance_test = PerformanceTest.new(performance_test_params)
    performance_test.run_tests
    performance_test.save!
    
    unless performance_test.passed
      AdminMailer.with(performance_test_id: performance_test.id ).test_failure_email.deliver_later
    end

    render json:{
      passed: performance_test.passed,
      ttfb: performance_test.ttfb,
      tti: performance_test.tti,
      speed_index: performance_test.speed_index,
      ttfp: performance_test.ttfp
    }, status: :ok
  end

  def list
    url = param! :url, String, required: true
    performance_tests = PerformanceTest.where(url: url)
    
    render json: performance_tests, status: :ok
  end

  def latest
    url = param! :url, String, required: true
    performance_test = PerformanceTest
      .where(url: url)
      .order(created_at: :desc)
      .first

    render json: performance_test, status: :ok
  end

  
  private


  def performance_test_params
    param! :max_speed_index, Integer, required: true
    param! :max_ttfb,        Integer, required: true
    param! :max_ttfp,        Integer, required: true
    param! :max_tti,         Integer, required: true
    param! :url,             String,  required: true

    params.permit permitted_performance_test_params
  end

  def permitted_performance_test_params
    [:max_ttfb, :max_tti, :max_speed_index, :max_ttfp, :url]
  end

end
