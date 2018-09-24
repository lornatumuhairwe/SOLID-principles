# Disobeys OCP

class Unsubscribe
  def unsubscribe!
    SubscriptionCanceller.new(user).process
    CancellationNotifier.new(user).notify
    CampfireNotfier.announce_sad_news(user)
  end
end

# Follows OCP
class UnsubscriptionCompositeObserver
  def initialize(observers)
    @observers = observers
  end

  def notify(user)
    @observers.each do |observer|
      observer.notify(user)
    end
  end
end

class Unsubscriber
  def initialize(observer)
    @observer = observer
  end

  def unsubscribe!(user)
    observer.notify(user)
  end
end

# this way, unsubscriber doesn't care how many things are happening when unsubscribing happens.
# Besides you can now notify more entities, without modifying the existing classes.