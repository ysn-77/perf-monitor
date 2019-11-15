# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview

  def test_failure_email
    AdminMailer.with(performance_test_id: PerformanceTest.first.id).test_failure_email
  end

end
