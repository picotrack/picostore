class User < ApplicationRecord
    has_secure_password

    def welcome
        "Hello, #{self.name} #{self.email}"
    end
end
