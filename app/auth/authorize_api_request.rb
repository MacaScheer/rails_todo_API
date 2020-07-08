class AuthorizeApiRequest
    def initialize(headers = {})
        @headers = headers
    end

    # Service entry point - return valid user object

    def call
        {
            user: user
        }
    end

    private

    attr_reader :headers

    def user
        @user || User.find(decoded_auth_token[:user_id]) if decoded_auth_token

        # handle user not found
    rescue ActiveRecord::RecordNotFound => e
        raise(ExceptionHandler::InvalidToken, ("#{Message.invalid_token} #{e.message}"))
    end

    def http_auth_header
        if headers['Authorization'].present?
            return headers['Authorization'].split(' ').last
        end
        raise(ExceptionHandler::MissingToken, Message.missing_token)
    end
end