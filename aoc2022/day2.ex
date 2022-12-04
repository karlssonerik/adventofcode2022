defmodule Day2 do
  def run do
    IO.puts(battle(input(),0))
    IO.puts(battlePart2(input(),0))
  end

  def battle(inp, score) do
    if length(inp) == 0 do
      score
    else
      shapes = String.split(hd(inp), " ")
      turnScore = battleValue(Enum.at(shapes, 0), Enum.at(shapes, 1)) + shapeValue(Enum.at(shapes, 1))
      battle(tl(inp), score+turnScore)
    end
  end

  def battlePart2(inp, score) do
    if length(inp) == 0 do
      score
    else
      shapes = String.split(hd(inp), " ")
      newShape = newShapePart2(Enum.at(shapes, 0), Enum.at(shapes, 1))
      turnScore = battleValue(Enum.at(shapes, 0), newShape) + shapeValue(newShape)
      battlePart2(tl(inp), score+turnScore)
    end
  end

  def newShapePart2(n, m) do
    cond do
      n == "A" ->
        cond do
          m == "X" -> "Z"
          m == "Y" -> "X"
          m == "Z" -> "Y"
        end
      n == "B" ->
        cond do
          m == "X" -> "X"
          m == "Y" -> "Y"
          m == "Z" -> "Z"
        end
      n == "C" ->
        cond do
          m == "X" -> "Y"
          m == "Y" -> "Z"
          m == "Z" -> "X"
        end
    end
  end

  def shapeValue(n) do
    cond do
      n == "X" -> 1
      n == "Y" -> 2
      n == "Z" -> 3
      n == "A" -> 1
      n == "B" -> 2
      n == "C" -> 3
    end
  end

  def battleValue(n, m) do
    cond do
      n == "A" ->
        cond do
          m == "X" -> 3
          m == "Y" -> 6
          m == "Z" -> 0
        end
      n == "B" ->
        cond do
          m == "X" -> 0
          m == "Y" -> 3
          m == "Z" -> 6
        end
      n == "C" ->
        cond do
          m == "X" -> 6
          m == "Y" -> 0
          m == "Z" -> 3
        end
    end
  end


  def inputEx do
    [
    "A Y",    "B X",    "C Z",    ]
  end

  def input do
    [      "A Z","C X","A Z","A Z","C Y","C Y","A Z","A Y","C Y","A Y","A Z","A Z","A Z","A Y","A Z","A Y","C Y","C X","A Y","C Y","C Y","C X","A Z","C Y","C X","A X","A Y","A Z","A Y","A Y","C X","C X","B Y","C X","C X","A Y","A Z","A Z","A X","A Z","A Z","C Y","A Z","A Z","A Y","C X","C Y","C X","B X","C Z","A Y","A Z","A Z","A Z","A Y","A Y","C X","A Y","A Z","C Y","A Y","A Y","A Z","A Z","C Y","A Z","C Y","A Y","A Z","A Z","C Y","B Z","A Z","A Z","A Z","A Z","C X","C X","A Y","A X","A Y","A Z","A Z","C X","A Z","C X","A Z","C Y","C X","A Z","A Z","A Z","A Z","C X","C Y","A Z","A Z","C Y","A Z","B Z","C X","A Z","A X","C X","A Z","C Z","A Z","C X","A Z","A Y","C X","C Z","A Z","C X","C Y","A Z","B Z","B Y","A X","A X","A X","A Z","A Z","A X","A Z","A X","A Z","A Z","C X","C X","B Z","A Z","A Y","A Z","A Z","A Z","A Z","C X","C X","C X","A Z","A Z","A Z","A Z","A X","A Y","A Y","C X","C X","B Z","C X","A X","A Z","A Z","C X","C Z","A Z","A Z","C Y","A X","A Z","C Y","A X","A Y","A Y","A Y","C Y","A Z","A Z","C X","C X","C X","C X","B Z","C Y","C X","C X","A Y","A Y","A Z","A Z","A X","C X","A Z","B Z","A Z","C X","A Y","A Z","A Z","A Y","A Y","A Z","C X","A Y","C X","C X","A Z","A Y","C X","A Z","A Z","A Y","A Z","A Z","C Y","C Z","A Y","A Z","C X","C X","A Z","A Z","C Y","A Y","A Z","A Y","A Z","C X","A Z","A Z","C X","A Y","A Y","C Y","A Z","C Y","A Z","A Z","C Y","A Y","B Z","C Y","C X","C X","A Z","C Y","A X","C Y","A Z","A Y","A Z","C X","C X","C Y","C Y","A Y","A Z","C X","C X","A Y","A X","A Y","B Z","A Y","C Y","C X","C X","A X","C X","B Z","A X","C Y","C X","C X","A X","A Z","B Z","A Z","A Z","A Y","A X","A Z","C X","A X","C Y","A Z","A Z","A X","A Z","A Z","C X","C X","A Z","A Z","A Z","A X","A Z","A X","B Y","A Z","A Y","C Y","A Z","C X","A Z","C X","A Y","A Z","C X","C Y","A Y","C Y","A Z","C X","A Z","A Z","C X","A Y","A Z","A X","A Z","A Z","A Z","B Y","C X","A X","A Z","A Z","C Y","C Y","C X","C X","C X","A X","A X","A Z","A X","A Y","A Z","A Y","A Z","C Y","C Z","A Y","A Z","A Z","A X","A Z","A Z","C X","C Y","A Y","C X","C X","A Z","C X","C X","C X","A X","A Z","A Z","A Z","A Z","B Y","A Y","A Y","A Z","C X","A Y","A Z","C X","A Z","C Z","A Y","C X","A Z","B Z","A Y","A X","A Z","C X","A Z","A Z","A Z","A Z","A Z","B Z","A Z","C X","A Y","C X","A Z","A Z","A Y","A Z","B Z","C X","A Y","C Y","A Z","A Z","C X","C X","A Y","C X","C Y","B Z","A Y","C X","A Y","C X","A X","A Y","A Z","A Z","A Y","C X","A X","C X","B Y","A Z","A Y","B Y","A Y","C X","A Z","A Z","C X","C Y","A Y","C X","C Y","A Y","A Z","A X","B Z","C X","A Z","A Y","A Z","B Z","A Z","A X","C Y","A X","A Z","A Y","C Y","A Z","C Y","A Z","C X","C X","A Y","C X","C X","A Y","A Z","A Z","A Y","A X","C Y","A Z","A Z","C X","A X","A Z","C Z","A Z","C Y","A Z","C X","A Z","A Z","A X","C X","C X","C Y","B Z","B Y","C Y","A Y","A X","A Z","C X","A Y","A Y","A Z","A Z","C Z","C X","C X","C X","A Z","C X","A Z","A Z","A Y","C Y","C X","C X","C X","A Y","C X","B Z","C X","A Z","C Y","A Y","C Y","A Z","A Z","C X","A X","A Z","A Y","A Z","B X","C Z","A Z","C Z","A X","C X","C X","C X","C X","A Z","A Y","A Z","A Z","A Z","A Z","A Z","C Z","C Y","C Y","C X","C Y","A Z","C X","C X","A Z","A Z","C X","C Y","C Y","A Z","A X","C Y","C Y","C X","A Y","C X","A Z","A Z","A Y","C Y","A Y","C X","C X","A Z","A Z","C Y","A Z","C X","A Y","A Y","A Z","C Y","A Z","C X","A Y","A Z","A Z","A Z","A Z","C Y","A Y","C Y","A Z","A Z","A X","A Y","A Y","A Z","C Y","A Z","A X","A Z","B Z","C X","C X","C Y","A Z","A Z","C X","C Z","A Z","C X","C Y","A Z","B Z","A Z","B Z","A X","A Y","A Z","A Z","A Z","A Z","C Y","A Z","A Z","A Z","B Z","A Z","C X","C X","A Z","C X","A X","A Z","A Y","A Y","A X","A Z","A Z","A Z","A Z","B Z","A Z","C Y","C Y","C X","C X","B Z","C Y","A Z","C Y","A Z","A Y","C Y","A X","A Y","C X","A Y","C X","A Z","A Z","B Z","A Y","C Y","C X","A Z","A Z","C X","A Y","A Z","A Z","A X","A Y","A Y","A Y","A Z","A Y","A Z","C X","A X","A Z","A Z","C Y","A Z","C X","A Z","C Y","A Y","A Z","A Z","A Z","A Z","C Y","A X","A Z","A Z","A Y","A Z","B Z","A X","A Y","C X","C X","A Y","A Z","C Y","A Z","A Y","A Y","A Z","A Y","A Y","A Z","A Z","A Z","C X","A Z","A Y","A Z","A Z","C Y","A Z","C X","A Y","C X","C Y","A Z","C Y","A Z","A Y","C Y","C Y","A Z","C X","C X","C X","A Z","A Z","A Y","C X","A Z","A X","A Z","A Z","C X","A Z","C Y","A Y","A Z","A Y","A Z","A Z","C Y","A Z","C X","A Z","A X","A Z","A Z","C X","A Z","A Z","C Y","C X","A Z","C Y","C X","C X","A Z","A Z","A Z","A X","C X","A Z","A Z","C Y","A Y","C X","A Y","C X","C Y","A Y","A Z","C X","A Z","B Y","A X","B Z","A Y","A X","C Y","A Z","A X","A Z","A Z","C Y","A Z","B Z","C X","C X","B Y","A Z","A Z","A Z","C Y","C X","A Z","A Y","A Y","A Y","C Y","C X","A Z","A X","A X","A X","A Z","A Z","A Z","A Z","C X","C X","A Z","C X","A Y","C X","B Z","A Z","A Z","C X","A Z","C X","C X","C X","A Y","C Y","C X","A Y","C X","C Y","B Z","A Z","C X","A Z","A X","B Z","A Y","B Y","A Z","A Z","A X","A Z","A X","A Z","A Z","C X","C Y","A X","C Y","C X","A Z","A Z","A Z","C Y","A X","A Y","A Z","A Y","C X","B Z","A Z","A Y","C Z","C X","A Z","A Z","A Z","B Z","A X","C X","A Z","A Z","B Z","A Z","A Z","B Z","A Z","C X","A Z","C X","A Z","C X","A Z","C Y","A Z","A X","A Y","A Y","C X","A Y","C X","B Z","A Z","A Z","A Z","A Z","C X","A Z","C X","A Z","A Y","A Z","B Z","A Y","C Z","A Y","C X","A Z","A Z","A Y","B Z","A X","C Y","A Z","A Y","A Z","A Y","A Y","A Z","A Z","A Z","A X","A Z","C Y","A Y","A X","A Y","C X","A Y","C X","A X","C X","A Z","C Y","A Y","A Z","A Z","A X","A Y","C X","C X","A Y","A X","A Z","B Z","A Y","A Z","A X","A Z","B Y","A Y","A Y","A Z","C X","A Z","A Z","A Y","A Z","C Z","A Z","A Z","A Z","A Z","C Y","C Y","A Y","B Z","C Y","A Y","C Y","A Z","A Z","A Z","A Z","C Y","A Z","A Z","C Y","C X","A Y","A Y","A Z","C X","C Z","C X","C X","A Z","A Z","A Y","A Z","A X","C Y","A Z","A Z","C Y","C X","A X","A Z","A Z","A X","C X","C X","C X","A Z","A X","C X","C Y","A X","A Z","C X","A Z","A Z","C X","A Y","A Z","A Z","A Y","A Z","C X","A Z","A Z","C X","A Y","A Z","A Z","C X","A Z","A Y","A Z","C Y","A X","A Z","A Z","C X","A Z","A Y","C Y","B Z","A Z","A Y","C X","A Z","B Z","A Z","C Z","A X","A Z","A Z","C Y","A Z","A Y","C X","C Y","A Z","A Z","A Y","A X","C Y","A Y","C X","C Y","A Z","C Y","A Z","C X","A Z","A Z","A X","A Z","A Z","B X","A X","A Z","C Y","A Z","A X","C X","A Z","A Z","C X","C Y","C Y","A X","A Y","C Y","A Y","A Z","A Z","A Z","A Z","A Y","C X","C X","C Y","C X","A Z","A X","B Z","B Y","C X","C Y","A Y","A Z","A Y","C X","C Z","A Z","A Y","C Y","C X","A Z","A Z","A Y","C X","C Z","C Y","A Z","C X","C Y","A X","A X","A Y","A Z","B Z","A X","A Y","A Y","C X","C Y","A Z","A X","A Z","A X","A Y","A Z","A Z","A Z","C X","A Z","A Z","A Z","C Z","C Y","C Y","A Z","C Y","C Y","C Y","C X","A Z","C X","C X","A Z","A Y","A Z","A Z","A X","A Y","A Y","C X","C X","A Z","A Z","A Z","A Z","A Y","A Z","A Z","A Z","A Z","A X","A X","A Y","A X","C Y","A Y","A Z","C X","A Y","A Y","A Z","A Z","A Z","C X","A Z","C X","C X","C Y","A Y","A Z","A Y","A Z","C X","C X","A Z","A Z","A Z","C X","A X","A Z","A Z","C Y","C Y","A Y","A Y","A Z","A Z","C Y","C X","C Y","A X","C Y","C X","C Y","A Z","A Z","A X","C Y","C Y","A Z","A Y","C X","A X","B Z","A Z","C X","A Y","A X","A Z","A Z","A Z","C Y","C X","A Z","C X","A Z","A Z","A Y","A Z","A Y","A X","A Z","C Z","A Z","A Z","A Z","A X","A Z","A X","C X","A Z","A Z","C Y","A X","A Z","C X","C X","A Y","A Z","A Z","C X","B X","A Z","C Y","A Z","C X","A Y","A Z","C X","A X","A Z","A X","A Z","C X","A Z","A X","A Z","C X","C Y","A Y","A X","A X","A Z","C Y","C Y","A Y","A Y","A Y","A X","A Z","A Z","A Z","C Y","C Y","A Y","B X","B X","A Z","C X","C X","A Z","C Y","C X","A Z","A Z","A Z","A Z","C X","A Z","A Z","C Y","A Y","C Y","A Z","C Y","C Y","A Z","C X","A Z","A X","A Z","C X","C X","A Y","B Z","A Y","C Y","A Z","C Y","A X","C X","A Y","C X","A Z","C Z","C Y","A Z","C X","C Y","A Z","A X","A Z","A Z","A Z","C X","A Z","A Z","A Z","A Z","A Z","A Z","A Z","A Z","A Z","A Y","A Z","A X","A Y","C Y","B Y","C X","B Z","A Z","A Z","A Y","B Z","A Z","A Z","C X","C Y","C X","A Y","A X","C X","C Y","A Y","C X","C Y","A Z","A Z","A Z","A Y","C X","A Y","C X","B Z","A Z","A Y","A Z","A Z","A Y","C X","A Z","C X","C Y","A Y","A Z","B Z","C X","A Y","C X","A Y","A Z","C X","A X","C X","B Y","C X","A Z","A Y","A Z","A Y","A X","C X","C X","A Y","C X","A Y","A Y","A X","B Y","A Y","C X","C X","A Y","B Z","B X","B Z","A Y","A Z","C Y","A Y","B Y","A Z","C X","A Z","A Z","A Z","A Z","B Z","C X","C Y","A Z","C Y","C Y","A X","C X","A Z","A Z","A Z","C X","C X","C X","A Y","C Z","C Z","A Z","C X","A Y","A Z","A Z","A Z","C X","A Z","A X","A Z","A Z","A Z","A Z","A Y","C Y","C X","A X","A Y","C X","A X","A Z","A Z","C X","A Z","A X","A Z","A Z","A X","A Z","A Z","A X","A Z","A X","B Y","A Y","A Y","C Y","A Z","A Y","C X","A Z","A Y","A X","C Y","B X","C Y","A Z","C X","A Y","A Z","A Y","A X","C Y","A Z","A Z","C Y","C X","A Z","C X","A Y","C X","A Z","A Y","A Z","A Z","A Z","A Y","A Z","C X","C X","A X","C X","C X","A Z","C X","A Z","C Y","C X","A Z","A Z","A Z","C X","A X","C Y","A Z","C Y","A X","A Z","C X","A Z","A Z","A X","A Z","C X","B X","A Z","A Z","A Z","C X","A Y","A Y","A X","C Y","C Y","A Z","A Y","A Z","A Z","C X","A X","A Y","A Z","A Z","A Z","A Z","B Z","C X","C X","C X","A Z","C Z","A X","C X","A Z","C Y","A Z","A Z","A Y","A Y","C X","A Z","A X","A Z","A Z","A Z","A Z","C Y","A Z","A Y","A X","A X","A Z","C X","A X","A X","A Z","A Y","C X","A Z","A Z","A Y","A Z","B Z","C X","C X","C Z","C Y","C X","A Z","C Y","A Z","C Z","A Z","A Y","A Y","A X","A X","A Z","A Y","A Y","A Y","A Y","A Z","C Y","A Z","A Z","C X","A Z","A Z","C Y","A Y","C X","A Y","C X","A Z","B Z","A X","B X","A Y","A X","A Y","B Z","A Y","A Z","C Y","C Y","A Z","A X","A Z","A Z","C Z","A Z","A Y","C X","A Y","C X","A X","A Y","C Y","A Y","A Z","A Z","C X","C X","B Z","A Z","A Z","A X","C X","C Y","A Z","A Z","A X","C X","C Z","A Z","C Y","A Y","B Z","C Y","A Z","C X","A X","A Z","A Z","A Z","A Y","C Y","A Z","C Y","A Z","A Z","A Z","A Z","A Y","C X","A Y","C Y","B Z","A Z","C X","C Y","A Z","C X","A Z","C X","C Z","A Z","C X","C X","A Z","A Z","A Y","A Y","A Y","C X","A Y","A Z","A Z","A Z","A Z","A Z","A Z","A Y","A Z","A X","C Y","A Z","A Z","A Z","A Y","A Z","A Z","A Z","A Z","C X","B Z","A Z","A Y","A Y","A X","A Z","A Z","C Z","A Z","C X","A Y","A X","B Z","A Z","A Z","A Z","C Y","C Z","C X","A Z","C Y","C Y","C Y","C X","B Z","A Z","A Z","C Z","A X","A Z","A Z","A Z","C X","A Z","A Z","C Y","C Y","A Z","A Z","C X","A Y","C Y","C Y","A Z","A Z","A X","A Z","A Z","A X","A X","C X","A Z","A X","C X","C X","A Z","A X","A Z","C X","C X","C X","C Y","A Z","A Z","A X","A Z","A Y","A Z","A Z","C Y","A Z","A Z","A Z","A X","A Z","C X","A X","A Z","A Z","A Z","A Z","A Z","A Z","A Z","A Y","A X","A Y","A X","C Y","A Z","A Z","C X","A Z","A Z","A Z","A X","A Z","A Z","A Y","C X","A Y","A Z","C X","A X","A Y","A Z","A Z","A X","A Z","A Y","C X","A Y","A Z","A Z","A Z","A Z","C X","C Y","A Z","B Z","C X","A Z","A Z","C Y","C Y","C X","A X","C Y","B Y","A Z","A Z","A Z","C Y","A Z","A X","A Y","A Z","A Z","A Z","C Y","A Z","C Y","C X","A Z","A Z","A Z","A Z","A Z","A X","A Z","A Z","C X","A Z","A Y","C Z","A Z","A Z","A Z","B X","C X","A Z","A Z","A Z","A Z","C X","A Z","A Z","A Y","A X","C X","C Y","A X","A Y","C X","A Z","A Z","C X","C X","A Z","C X","A Z","A Y","C X","A Z","B X","B Y","A X","C Y","A X","A Y","C Y","A Z","A Z","A Z","C X","A Z","A X","A Z","C Y","A Z","A Z","C X","A Z","A Z","A Y","A Z","A X","A Y","A Z","C X","C Y","B X","C Y","A Y","A Z","C X","A Z","C X","C Y","A X","A X","A Z","A Z","C Y","A Y","A Y","A Z","A Z","C X","A X","C X","A X","A Y","C X","A Z","A Z","B Y","A Z","A Z","A Z","A Z","A Z","A X","A Y","A X","A Z","A Z","C X","A Y","A Z","C Y","C X","C X","C X","C X","C Y","A X","A X","C Y","A X","A Y","A Y","B Z","A Z","B Y","C Y","A X","A Y","A Z","A Z","A Z","A X","C X","A Z","A Z","A Z","A Z","A Z","A Y","A Z","B Z","A Z","A Z","A Y","C Y","C Y","C X","A Z","A X","C X","A Y","B Z","C X","A Z","C X","C Y","C Y","A X","A X","C X","A Z","A Z","A Y","A X","A X","A Z","C Y","B X","A Z","A Z","A Z","A Z","A Y","A Y","A Z","C Y","C Y","A X","A Z","A Z","C Y","A Y","A Y","A X","A Y","A X","A X","A X","A Z","A Z","A Y","A Z","C X","A Z","A Y","A Z","A Z","A Y","A Z","A Z","C X","A Z","A Y","A Z","A Z","A Z","A Z","A Z","A Z","A Y","C X","B Z","C Z","A Z","A Y","A X","A X","C Y","C Y","A X","C X","B Z","A Z","C X","A Z","A Z","A Z","A Z","A Z","A Z","A Z","A Y","A Z","A Z","A Y","A Z","A Y","A Y","A Z","A Z","A Y","A Z","C Y","A Z","A Z","A Z","C X","C X","A Z","C Y","A Z","A Z","C X","A Z","C X","A Y","A Z","C Y","A Z","A Z","C X","C Y","A Z","C X","C X","A X","A Y","C Y","A Y","A Z","C X","A Z","A Z","A X","A Z","C Y","A Z","C X","A Z","C X","A Z","C X","A Y","C Y","A X","A Z","A Z","C Y","A X","A Z","A Y","B Z","A Z","A X","A Z","A Z","A X","C X","A Z","A Z","C Y","A Z","A Y","A Z","C Y","A Z","A Y","A Z","C Z","A Y","A Z","A Y","C Y","A Z","C X","A X","B Z","C X","C X","A Z","A Z","A Y","A X","A Z","A Z","B Z","A Z","C Z","A X","A Z","A Z","A Z","A Z","A X","A X","A Z","A X","A Z","A Z","A Z","A X","C X","C Y","A X","C X","C X","A Z","A X","C Y","B Z","A Z","A Z","C X","B X","A Z","A Z","C X","C X","B Z","C Y","A Z","A Z","C X","A X","A Y","C Y","C Y","B Z","A Y","C X","A Z","A Z","A Y","C X","A Z","A Z","C X","C Y","A Z","C X","C Y","C Y","C X","C Y","A Z","C Y","A Z","C X","A Z","C Y","C Z","A Z","B Z","A Z","C X","C X","B Y","B Z","C Y","C X","C X","A Y","C X","C X","A Z","A Y","A Z","C X","A X","A Z","A Z","A Z","A Z","A Z","A Z","A Z","C X","C X","A Z","C Y","C X","A Z","B Z","A Z","A Z","A X","C X","A Y","A Z","A Z","A Y","A X","C Y","B X","A Z","A X","C Y","C X","C X","C Y","C Y","A Z","A Z","C Y","A Z","A Y","C Y","A Y","C X","A Z","C X","C Y","C Y","A Z","A Z","A X","A Y","A Z","A X","A Z","A Z","A Z","C Y","A Z","A Z","C X","C Y","A Z","A Z","A Z","C Y","C X","A Z","C X","A Z","A Z","A Z","A X","A Z","A Z","A Y","B Z","A Z","A Z","A Z","C Y","A Z","B Z","A Z","C Z","A Z","A Y","C X","C Y","C X","C X","A Z","A Z","A Y","A Y","A Z","A Y","B Z","C Y","A Y","A Z","C X","A Z","A Z","C Y","A Y","A Z","A Y","C Y","A Z","A Z","A X","B Z","A Z","A X","C X","A Z","C Y","C Y","A Z","B Y","A Y","A Z","A Z","A Z","A Z","C X","C X","A Z","C X","A Y","A Z","A Z","C Y","A Z","A Z","C Y","C X","B Z","A Y","A Y","C X","C X","A Z","A X","B Z","A Z","C Y","A Z","A Y","A Z","A Z","A Y","C Y","C X","A Z","C X","A Z","C Y","A Z","C Y","A Y","A Z","A Y","A Z","C X","A Z","A Z","C X","A Z","B Y","A Z","A Z","C Y","C X","C X","A Z","A Z","C X","B Z","A Y","A Z","A Y","A Z","A Z","A Y","A X","C X","C X","A X","A Z","A Y","A Y","A Z","A Y","A Z","A Z","C Y","A X","A Z","A Z","C X","A Z","A X","B X","C X","A Z","A Y","B Z","C X","C Y","A Z","B Z","C Y","A Z","A Z","A X","A Z","A Z","A Z","A Z","A Z","A Z","A Z",    ]
  end
end

Day2.run()
