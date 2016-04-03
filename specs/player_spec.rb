require_relative "spec_helper.rb"

describe Player do
  describe "#new" do
    context "when given no input" do
      it "raises ArgumentError" do
        expect{Player.new}.to raise_error(ArgumentError, "Requires team_color Symbol, and Board reference")
      end
    end

    context "when given input" do
      context "and input has incorrect number of parameters" do
        it "raises ArgumentError" do
          expect{Player.new(4, [], :apple)}.to raise_error(ArgumentError)
          expect{Player.new(5, 5, 5, 4)}.to raise_error(ArgumentError)
        end
      end

      context "when input is incorrect type" do
        it "raises ArgumentError" do
          expect{Player.new("black", 5)}.to raise_error(ArgumentError, "Requires team_color Symbol, and Board reference")
        end
      end

      context "when input is correct" do
        before(:each) do
          @board = Board.new
          @player = Player.new(:black, @board)
        end

        it "does not raise error" do
          expect{Player.new(:white, Board.new)}.not_to raise_error
        end

        it "creates a new Player object" do
          expect(@player).to be_instance_of(Player)
        end
      end
    end
  end

  describe "#team_color" do
    before(:each) do
      @player = Player.new(:white, Board.new)
    end

    it "is set to Symbol initialzied and can be read" do
      expect(@player.team_color).to eql(:white)
    end

    it "is cannot be set" do
      expect{@player.team_color = :black}.to raise_error(NoMethodError)
    end
  end

  describe "#board" do
    before(:each) do
      @board = Board.new
      @player = Player.new(:white, @board)
    end

    it "can be read" do
      expect{@player.board}.not_to raise_error
    end

    it "is a Board object" do
      expect(@player.board).to be_instance_of(Board)
    end

    it "is the initialized board" do
      expect(@player.board).to eql(@board)
    end
  end

  describe "#select" do
    before(:each) do
      @board = Board.new
      @player1 = @board.players[0]
      @player2 = @board.players[1]
    end

    context "when given no input" do
      it "raises ArgumentError" do
        expect{@player1.select()}.to raise_error(ArgumentError)
      end
    end

    context "when given input" do
      context "and input is not String" do
        it "raises ArgumentError" do
          expect{@player1.select(['poop'])}.to raise_error(ArgumentError, "Input must be String")
          expect{@player1.select(5)}.to raise_error(ArgumentError, "Input must be String")
          expect{@player1.select(:incorrect)}.to raise_error(ArgumentError, "Input must be String")
        end
      end

      context "and input is string" do
        context "but string is not valid" do
          it "raises ArgumentError" do
            expect{@player1.select("poop")}.to raise_error(ArgumentError, "Input incorrect. Example: C4, B2, A3, etc.")
            expect{@player1.select("4C")}.to raise_error(ArgumentError, "Input incorrect. Example: C4, B2, A3, etc.")
            expect{@player1.select("top left")}.to raise_error(ArgumentError, "Input incorrect. Example: C4, B2, A3, etc.")
          end
        end

        context "when input is valid" do
          it "does not raise error" do
            expect{@player1.select("C2")}.not_to raise_error
            expect{@player1.select("C 2")}.not_to raise_error
            expect{@player1.select("  C  2  ")}.not_to raise_error
          end
        end
      end
    end
  end
end