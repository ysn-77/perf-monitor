class AdminMailer < ApplicationMailer
  # default from: 'performance@test.com'

  def test_failure_email
    @performance_test = PerformanceTest.find(params[:performance_test_id])
    mail(
      to: ENV.fetch('APP_ADMIN_EMAILS', '').split(','),
      subject: "Performance tests failed for #{@performance_test.url}"
    )
  end

end
