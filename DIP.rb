# Dependency Inversion Principle
# Higher level modules should not depend on lower level modules
# Instead both should use abstraction.
# In short, do not mix business logic with lower level implementation details.
#
# This happens naturally with the use of OCP and LSP
#

# violates DIP
class Copier
  def self.copy
    reader = KeyboardReader.new
    writer = Printer.new

    keystrokes = reader.read_until_eof
    writer.write(keystrokes)
  end
end

# Obeys DIP. Is decoupled and reusable
class Copier
  def initialize(reader, writer)
    @reader = reader
    @writer = writer
  end

  def copy
    @writer.write(@reader.read_until_eof)
  end
end

# Since you are not concerned with the other classes directly,
# you can easily swap them out, which is very convinient for testing.
Copier.new(Keyboard.new, Printer.new)
Copier.new(Keyboard.new, NetworkPrinter.new)
