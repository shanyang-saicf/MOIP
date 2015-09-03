module Errors
  class RaiseError

    def on_complete(env)
      return if (status = env[:status]) < 400
      case status
        when 404
          raise Errors::NotFound
      end
    end

  end
end