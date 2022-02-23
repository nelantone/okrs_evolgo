class ApplicationController < ActionController::Base
  include ResponseJsonHandler
  include ExceptionHandler
end
