# Interface Segregation Principles
# states that clients should not be forced to depend on methods that they do not use.

# This is not a problem in dynamically typed languages like ruby.
# But in a language like Java, if you have a class A that uses 6 methods
# and there is another class B that uses one method in this class, class B, should
# not have to get all the 6 methods from A. Instead, class A, can use interfaces.
# The 6 methods in A can be divided into interfaces and class A can implement
# both of them while class B can implement one interface with the method is depends on.

