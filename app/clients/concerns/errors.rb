module Errors
  extend ActiveSupport::Concern

  class APIExceptionError < StandardError
    attr_reader :status, :message

    def initialize(status, message)
      @status = status
      @message = message
    end
  end

  def error_class(status, message)
    APIExceptionError.new(status, message)
  end
end