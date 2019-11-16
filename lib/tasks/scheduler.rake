namespace :scheduler do
  
  desc "Re-test the performance of all the urls, send an email if they fail"
  task run_performance_tests: :environment do
    PerformanceTests.where(original_test_id: null).each do |test|
      cloned_test = test.dup
      cloned_test.original_test_id = test.id
      cloned_test.run_tests
      cloned_test.save

      unless cloned_test.passed
        AdminMailer.with(performance_test_id: cloned_test.id ).test_failure_email.deliver_now
      end
    end
  end

end
