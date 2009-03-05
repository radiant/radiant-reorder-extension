require 'test/unit'
# # Load the environment
unless defined? RADIANT_ROOT
  ENV["RAILS_ENV"] = "test"
  require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../")}/config/environment"
end

require 'dataset'
class Test::Unit::TestCase
  include Dataset
  datasets_directory "#{RADIANT_ROOT}/spec/datasets"
  Dataset::Resolver.default << "#{File.expand_path(File.dirname(__FILE__) + "/datasets")}"
 
  # for login_as helper
  def request
    @request
  end
end
