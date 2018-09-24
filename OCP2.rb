# Does not obey OCP, because, if we are to to print another type,
# we are going to add another case when to check the type.
class Printer
  def initialize(item)
    @item = item
  end

  def print
    thing_to_print = case @item
    when Text
     @item.to_s
    when Image
     @item.filename
    when Document
     @item.formatted
    end

    send_to_printer(thing_to_print)
  end
end

# Obeys OCP, by making use of polymorphism
class Printer
  def initialize(item)
    @item = item
  end

  def print
    send_to_printer(@item.printable_representation)
  end
end
