class Guess
  attr_accessor :num, :guess

  def initialize
    @num = rand(10)
  end

  def play
    until @num == @guess
      puts "Guess a number"
      guess = gets
      @guess = guess.to_i
      report
    end
  end

  def report
    if (@num > @guess)
      puts "Too low..."
    elsif (@num < @guess)
      puts "Too high..."
    elsif (@num == @guess)
      puts "You guessed it!"
    else
      puts "Something weird: #{@guess}, #{@guess.class}"
    end
  end
end