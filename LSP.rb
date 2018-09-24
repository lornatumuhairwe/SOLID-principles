# The principle states that you should be able to replace any instances of a
# parent class with an instance of one of its children without creating any
# unexpected or incorrect behaviors.

class Signup
  def initialize(attributes)
    @attributes = attributes
  end

  def save
    account = Account.create!(@attributes[:account])
    account.users.create!(@attributes)
  end
end

class InvitationSignup < Signup
  def save(invitation)
    user = super
    invitation.accept(user)
    user
  end
end

class SignupsController
  def create
    signup = build_signup
    if params[:invitation_id]
      invitation = Invitation.find(params[:invitation_id])
      signup.save(invitation)
    else
      signup.save
    end
  end

  def build_signup
    if params[:invitation_id]
      InvitationSignup.new(params[:signup])
    else
      Signup.new(params[:signup])
    end
  end
end

# creates this mess, a chain of two if else statements

# to fix this, do as below
class InvitationSignup < Signup
  def initialize(attributes, invitation)
    super(attributes)
    @invitation = invitation
  end

  def save
    user = super
    @invitation.accept(user)
    user
  end
end

class SignupsController
  def create
    build_signup.save
  end

  def build_signup
    if params[:invitation_id]
      invitation = Invitation.find(params[:invitation_id])
      InvitationSignup.new(params[:signup], invitation)
    else
      Signup.new(params[:signup])
    end
  end
end
