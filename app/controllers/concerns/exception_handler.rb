module ExceptionHandler
    # provides the more graceful 'included' method
    extend ActiveSupport::Concern
    # create method of Todos Controller we use create! which will raise an exception'
    # This way we can avoid deep nested if statements in the controller
    # so we rescue from this exception
    included do
        rescue_from ActiveRecord::RecordNotFound do |e|
            json_response({message: e.message}, :not_found)
        end
        rescue_from ActiveRecord::RecordInvalid do |e|
            json_response({message: e.message}, :unprocessable_entity)
        end
    end
end