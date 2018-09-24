# Violates DIP
class UserCharger
  def initialize(user)
    @user = user
  end

  def charge!
    Stripe::Customer.charge(
      @user.stripe_customer_id,
      MONTHLY_SUBSCRIPTION_FEE
    )
  end
end

# Obeys DIP
class UserCharger
  def initialize(user, payment_gateway)
    @user = user
    @payment_gateway = payment_gateway
  end

  def charge!
    @payment_gateway.charge(
      @user.payment_uuid,
      MONTHTLY_SUBSCRIPTION_FEE
    )
  end
end

# Note that the method payment_uuid is added to user to generalize the payment id,
# instead of it being something tied to stripe. So, if you had different payment gateways, you could do this
# or you could pass the payment_uuid directly so that you can eliminate the method entirely.

# For cases where you have different payment gateways that implement different interfaces eg create_charge
# instead of charge, you could use an adapter class to make the code reusable for all.

class BrainTreeGateway
  def create_charge(amount, user_id)
    #...
  end
end

class BrainTreeGatewayAdapter
  def initialize(braintree_gateway)
    @braintree_gateway = braintree_gateway
  end

  def charge(user_id, amount)
    @braintree_gateway.create_charge(amount, user_id)
  end
end

# thanks to upcase https://thoughtbot.com/upcase/videos/dependency-inversion-principle