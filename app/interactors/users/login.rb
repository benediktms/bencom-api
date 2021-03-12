# frozen_string_literal: true

module Users
  class Login < BaseInteractor
    delegate :email, :password, to: :context

    def call
      return nil if password.empty?

      user = User.find_by(email: email)

      if user
        if user.authenticate(password)
          context.message = 'Successfully logged in'
          context.user = user
          context.token = user.generate_token
        else
          context.fail! message: 'That seems like a wrong password'
        end
      else
        context.fail! message: 'Could not find an account with that email, please sign up instead'
      end
    end
  end
end
