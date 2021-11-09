require './question'
require './player'

class Game

  attr_accessor :game_over

  def initialize
    @game_over = false
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @turn = 0
  end

  def start

    puts "----- NEW GAME -----"

    while !game_over do 
      if @turn % 2 == 0
        current_player = @player1
        other_player = @player2
      else 
        current_player = @player2
        other_player = @player1
      end

      question_answer = Question.get_question_answer
      question = question_answer[0]
      answer = question_answer[1][0]
      puts "#{current_player.name}: #{question}"
      player_answer = $stdin.gets.chomp.to_i

      if player_answer == answer 
        puts "#{current_player.name}: YES! You are correct."
      else 
        current_player.lives -= 1
        puts "#{current_player.name}: Sorry! Your answer is incorrect!"

        if current_player.lives == 0
          puts "#{other_player.name} wins! winning score is: #{other_player.lives}/3"
          puts "----- GAME OVER -----"
          @game_over = true
          break
        end

      end

      puts "P1: #{@player1.lives}/3 vs P2: #{@player2.lives}/3"
      @turn += 1
      puts "----- NEW TURN -----"

    end
  end

end