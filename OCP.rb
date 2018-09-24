# Open/Cloased Principle
# Classes should be open for extension and closed for modification

# disobeys OCP, because, incase you are to add another payment method, you would have to modify this class.
# by removing the Stripe entirely.
class Purchase
  def charge_user!
    Stripe.charge(user: user, amount: amount)
  end
end

# obeys OCP, because, the payments_processor is abstracted out and can be reused.
# It is thus Open for extension but doesn't need to be modified to increase its functionality.
class Purchase
  def charge_user!(payment_processor)
    payment_processor.charge(user: user, amount: amount)
  end
end
