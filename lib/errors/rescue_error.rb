module Errors

  module RescueError

    def self.included(base)
      base.rescue_from Errors::NotFound do |e|
        render file: "public/404.html", layout: false, status => 404
      end
    end

  end

end