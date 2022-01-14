ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def is_logged_in?
      !session[:user_id].nil?
    end
  end
end

module ActionDispatch
  class IntegrationTest
    def log_in_as(user, password: "foobar")
      post login_path,
           params: {
             session: {
               username: user.username,
               password: password,
             },
           }
    end
  end
end
