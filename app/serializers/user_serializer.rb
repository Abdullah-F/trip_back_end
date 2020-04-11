class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  def JWTtoken
    @options[:JWTtoken]
  end

  def expires_in
    @options[:expires_in]
  end
end
