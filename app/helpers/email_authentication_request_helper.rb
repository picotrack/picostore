module EmailAuthenticationRequestHelper
    def create_6_digit_code
        return rand.to_s[2..7]
    end
end
