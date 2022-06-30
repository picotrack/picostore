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

    def current_user
        if is_logged_in
            @user = User.find(session[:user_id])
            return @user
        end
    end
end
