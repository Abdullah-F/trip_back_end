class User::Authenticate
  include Interactor

  def call
    if authenticated?
      context.token = JsonWebToken.encode({ user_id: user.id }, context.exp)
    end
  end

  private

  def authenticated?
    user = User.find_by_email(email)
    context.user = user if user && user.authenticate(password)
    unless user.present?
      context.fail!(errors: [:user_authentication, "invalid credentials"])
    end
  end

  def email
    context.email
  end

  def password
    context.password
  end
end
