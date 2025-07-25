require "pgn/board"
require "pgn/fen"
require "pgn/game"
require "pgn/move"
require "pgn/move_calculator"
require "pgn/parser"
require "pgn/position"
require "pgn/version"

module PGN

  # @param pgn [String] a pgn representation of one or more chess games
  # @return [Array<PGN::Game>] a list of games
  #
  # @note The PGN spec specifies Latin-1 as the encoding for PGN files, so
  #   this is default.
  #
  # @see http://www.chessclub.com/help/PGN-spec PGN Specification
  #
  def self.parse(pgn, encoding = Encoding::ISO_8859_1)
    dup = pgn.dup # in case pgn is frozen
    dup.force_encoding(encoding) if encoding

    PGN::Parser.new.parse(dup).map do |game|
      PGN::Game.new(game[:moves], game[:tags], game[:result])
    end
  end
end
