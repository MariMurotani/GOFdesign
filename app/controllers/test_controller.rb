class TestController < ApplicationController
  def index
    logger2 = AnyLogger.instance
    @@logger.add_logs('test','This is test for flush logs', Account.system, Operation.dashboard)
    render json: {logger1: @@logger.object_id, logger2: logger2.object_id}, status: 200
  end
end
