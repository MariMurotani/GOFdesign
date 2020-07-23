class TestController < ApplicationController
  def index
    @@logger.add_logs('test','This is test for flush logs', Account.system, Operation.dashboard)
    render json: {}, status: 200
  end
end
