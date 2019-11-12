class PerformanceTestsController < ApplicationController
  rescue_from RailsParam::Param::InvalidParameterError, with: :show_parameter_errors

  def create
    performance_test = PerformanceTest.new(performance_test_params)
    performance_test.run_tests
    performance_test.save!
    
    render json:{
      passed: performance_test.passed,
      ttfb: performance_test.ttfb,
      tti: performance_test.tti,
      speed_index: performance_test.speed_index,
      ttfp: performance_test.ttfp
    }, status: :ok
  end

  def list
    url = get_url!
    performance_tests = PerformanceTest.where(url: url)
    
    render json: performance_tests, status: :ok
  end

  def latest
    url = get_url!
    performance_test = PerformanceTest
      .where(url: url)
      .order(created_at: :desc)
      .first

    render json: performance_test, status: :ok
  end

  
  private


  def performance_test_params
    get_url!
    param! :max_speed_index, Integer, required: true
    param! :max_ttfb,        Integer, required: true
    param! :max_ttfp,        Integer, required: true
    param! :max_tti,         Integer, required: true

    params.permit permitted_performance_test_params
  end

  def permitted_performance_test_params
    [:max_ttfb, :max_tti, :max_speed_index, :max_ttfp, :url]
  end

  def get_url!
    param! :url, String, required: true, format: PerformanceTest::VALID_URL_REGEX
  end

  def show_parameter_errors(exception)
    render json:{ error: exception.message }, status: :bad_request
  end
end
