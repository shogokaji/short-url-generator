module Exceptions
  class BadRequest < Base
    def initialize(code: nil, message: nil, payload: {})
      super(
        status: 400,
        code:,
        message: message || "We recieved invalid request.",
        payload:
      )
    end
  end
end