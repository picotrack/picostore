module ApplicationHelper
    def require_login
        redirect_to sessions_new_path unless session.include? :user_id
    end

    def is_logged_in
        if session.include? :user_id
            return true
        else
            return false
        end
    end
end
