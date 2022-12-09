defmodule Day5 do
  def run do
    IO.inspect(part1(inputStart(), inputMoves()))
    IO.inspect(part2(inputStart(), inputMoves()))
  end

  def part1(state, moves) do
    if length(moves) !=0 do
      currentMove = hd(moves)
      sParts = currentMove |> String.split(" ")
      weight = sParts |> getIntAt(1)
      source = sParts |> getIntAt(3)
      destination = sParts |> getIntAt(5)
      sourcelist = Map.get(state, source)
      dstlist = Map.get(state, destination)
      move = sourcelist |> Enum.slice(0, weight)
      newState = state |> Map.put(destination, Enum.reverse(move) ++ dstlist) |> Map.put(source, sourcelist -- move)
      #IO.inspect(newState)
      part1(newState, tl(moves))
    else
      Enum.each(state, fn {k,v} ->
        v1 = Enum.at(v, 0)
        IO.puts("#{k}  #{v1}")
      end)
      state
    end
  end

  def part2(state, moves) do
    if length(moves) !=0 do
      currentMove = hd(moves)
      sParts = currentMove |> String.split(" ")
      weight = sParts |> getIntAt(1)
      source = sParts |> getIntAt(3)
      destination = sParts |> getIntAt(5)
      sourcelist = Map.get(state, source)
      dstlist = Map.get(state, destination)
      move = sourcelist |> Enum.slice(0, weight)
      newState = state |> Map.put(destination, move ++ dstlist) |> Map.put(source, sourcelist -- move)
      #IO.inspect(newState)
      part2(newState, tl(moves))
    else
      Enum.each(state, fn {k,v} ->
        v1 = Enum.at(v, 0)
        IO.puts("#{k}  #{v1}")
      end)
      state
    end
  end

  def getIntAt(stringList, index)do
    Enum.at(stringList, index) |> Integer.parse() |> elem(0)
  end

  def inputEXStart do
    %{
      1 => ["N","Z"],
      2 => ["D","C","M"],
      3 => ["P"],
      }
  end

  def inputEXMoves do
    [
      "move 1 from 2 to 1",
      "move 3 from 1 to 3",
      "move 2 from 2 to 1",
      "move 1 from 1 to 2",
    ]
  end

  def inputStart do
    %{
      1 => ["L","C","G","M","Q",],
      2 => ["G","H","F","T","C","L","D","R",],
      3 => ["R","W","T","M","N","F","J","V",],
      4 => ["P","Q","V","D","F","J",],
      5 => ["T","B","L","S","M","F","N",],
      6 => ["P","D","C","H","V","N","R",],
      7 => ["T","C","H",],
      8 => ["P","H","N","Z","V","J","S","G",],
      9 => ["G","H","F","Z",],
    }
  end

  def inputMoves do
    ["move 5 from 8 to 2","move 2 from 4 to 5","move 3 from 3 to 9","move 4 from 1 to 8","move 5 from 9 to 1","move 3 from 3 to 8","move 2 from 4 to 7","move 6 from 6 to 5","move 5 from 2 to 4","move 2 from 9 to 1","move 1 from 7 to 1","move 4 from 7 to 3","move 5 from 1 to 5","move 3 from 1 to 4","move 8 from 5 to 3","move 7 from 3 to 2","move 10 from 4 to 7","move 1 from 7 to 3","move 1 from 6 to 2","move 3 from 8 to 4","move 4 from 3 to 2","move 1 from 1 to 2","move 4 from 3 to 1","move 2 from 1 to 7","move 3 from 5 to 1","move 7 from 8 to 4","move 9 from 5 to 1","move 9 from 2 to 7","move 6 from 4 to 9","move 14 from 7 to 5","move 2 from 1 to 4","move 6 from 7 to 1","move 4 from 4 to 9","move 6 from 2 to 8","move 2 from 4 to 9","move 2 from 9 to 3","move 3 from 8 to 3","move 5 from 9 to 4","move 1 from 2 to 9","move 5 from 5 to 3","move 3 from 2 to 7","move 1 from 1 to 4","move 3 from 7 to 5","move 4 from 9 to 6","move 2 from 9 to 3","move 5 from 1 to 6","move 7 from 6 to 5","move 1 from 2 to 3","move 10 from 1 to 5","move 1 from 8 to 3","move 14 from 3 to 7","move 1 from 8 to 4","move 2 from 6 to 1","move 28 from 5 to 9","move 1 from 2 to 1","move 5 from 4 to 6","move 2 from 4 to 3","move 13 from 7 to 8","move 1 from 3 to 5","move 1 from 5 to 2","move 1 from 3 to 6","move 1 from 5 to 6","move 22 from 9 to 1","move 1 from 2 to 7","move 3 from 9 to 5","move 2 from 7 to 5","move 18 from 1 to 4","move 7 from 8 to 3","move 4 from 6 to 8","move 2 from 5 to 8","move 5 from 3 to 9","move 2 from 5 to 1","move 3 from 6 to 8","move 1 from 5 to 9","move 2 from 3 to 6","move 10 from 1 to 5","move 15 from 8 to 6","move 10 from 6 to 8","move 1 from 9 to 4","move 1 from 1 to 3","move 4 from 4 to 3","move 5 from 3 to 5","move 9 from 5 to 6","move 13 from 6 to 5","move 8 from 5 to 7","move 8 from 9 to 6","move 2 from 6 to 4","move 2 from 6 to 2","move 3 from 7 to 4","move 2 from 2 to 8","move 1 from 5 to 4","move 3 from 7 to 9","move 1 from 5 to 9","move 5 from 6 to 9","move 10 from 8 to 3","move 3 from 8 to 1","move 5 from 9 to 2","move 1 from 6 to 4","move 4 from 5 to 6","move 7 from 3 to 7","move 5 from 6 to 5","move 19 from 4 to 8","move 15 from 8 to 3","move 2 from 1 to 5","move 7 from 5 to 9","move 2 from 7 to 2","move 3 from 3 to 8","move 5 from 5 to 8","move 10 from 9 to 3","move 1 from 4 to 2","move 10 from 8 to 3","move 29 from 3 to 2","move 2 from 3 to 4","move 1 from 1 to 5","move 2 from 8 to 4","move 1 from 9 to 1","move 1 from 3 to 9","move 1 from 1 to 9","move 2 from 3 to 4","move 33 from 2 to 1","move 2 from 2 to 4","move 1 from 3 to 1","move 22 from 1 to 2","move 6 from 4 to 9","move 4 from 7 to 1","move 16 from 1 to 4","move 3 from 7 to 6","move 2 from 9 to 4","move 1 from 5 to 2","move 9 from 4 to 2","move 1 from 6 to 5","move 7 from 4 to 2","move 6 from 9 to 8","move 4 from 4 to 9","move 4 from 8 to 3","move 2 from 4 to 3","move 2 from 2 to 5","move 2 from 5 to 2","move 1 from 5 to 6","move 3 from 9 to 5","move 1 from 6 to 8","move 2 from 6 to 5","move 1 from 3 to 2","move 1 from 8 to 4","move 2 from 8 to 2","move 5 from 5 to 6","move 44 from 2 to 8","move 1 from 4 to 8","move 3 from 6 to 8","move 2 from 6 to 2","move 37 from 8 to 3","move 1 from 9 to 4","move 1 from 2 to 5","move 5 from 8 to 6","move 1 from 4 to 6","move 1 from 2 to 4","move 16 from 3 to 2","move 1 from 4 to 5","move 1 from 8 to 3","move 4 from 8 to 2","move 1 from 8 to 7","move 2 from 5 to 8","move 15 from 2 to 4","move 5 from 6 to 3","move 1 from 7 to 4","move 1 from 8 to 9","move 1 from 6 to 7","move 1 from 8 to 3","move 2 from 2 to 8","move 1 from 9 to 3","move 2 from 8 to 4","move 1 from 4 to 6","move 33 from 3 to 7","move 1 from 6 to 3","move 1 from 4 to 8","move 1 from 8 to 9","move 4 from 4 to 3","move 9 from 4 to 7","move 3 from 4 to 8","move 11 from 7 to 2","move 14 from 7 to 6","move 1 from 8 to 3","move 1 from 9 to 5","move 1 from 5 to 1","move 8 from 2 to 9","move 1 from 8 to 7","move 6 from 3 to 6","move 18 from 6 to 4","move 1 from 2 to 7","move 1 from 3 to 6","move 14 from 4 to 2","move 4 from 4 to 3","move 3 from 6 to 3","move 19 from 2 to 6","move 16 from 6 to 8","move 1 from 1 to 8","move 16 from 8 to 7","move 3 from 9 to 4","move 3 from 6 to 2","move 3 from 4 to 7","move 4 from 3 to 2","move 2 from 2 to 4","move 4 from 9 to 8","move 5 from 2 to 8","move 29 from 7 to 5","move 6 from 8 to 2","move 2 from 3 to 4","move 2 from 2 to 6","move 1 from 3 to 5","move 4 from 2 to 6","move 8 from 7 to 5","move 1 from 7 to 5","move 2 from 8 to 6","move 1 from 8 to 7","move 6 from 6 to 1","move 2 from 7 to 6","move 1 from 9 to 7","move 3 from 1 to 7","move 3 from 6 to 1","move 1 from 7 to 6","move 3 from 1 to 6","move 1 from 1 to 5","move 4 from 6 to 3","move 2 from 4 to 2","move 38 from 5 to 6","move 3 from 3 to 8","move 4 from 8 to 6","move 22 from 6 to 8","move 1 from 7 to 8","move 2 from 6 to 2","move 2 from 5 to 2","move 2 from 2 to 1","move 2 from 4 to 6","move 2 from 2 to 1","move 1 from 1 to 9","move 2 from 8 to 5","move 2 from 2 to 8","move 2 from 5 to 2","move 2 from 7 to 2","move 1 from 3 to 1","move 4 from 1 to 8","move 1 from 9 to 5","move 1 from 1 to 7","move 1 from 2 to 8","move 29 from 8 to 3","move 15 from 3 to 2","move 12 from 2 to 5","move 1 from 1 to 6","move 3 from 2 to 1","move 6 from 3 to 8","move 2 from 3 to 9","move 1 from 6 to 7","move 12 from 5 to 8","move 2 from 7 to 1","move 2 from 1 to 4","move 2 from 4 to 2","move 1 from 5 to 8","move 1 from 3 to 6","move 2 from 3 to 4","move 3 from 1 to 4","move 5 from 8 to 9","move 4 from 4 to 2","move 5 from 9 to 6","move 26 from 6 to 8","move 7 from 2 to 8","move 3 from 3 to 1","move 1 from 6 to 4","move 14 from 8 to 6","move 2 from 1 to 2","move 1 from 1 to 3","move 18 from 8 to 5","move 15 from 8 to 2","move 5 from 6 to 8","move 4 from 5 to 8","move 7 from 2 to 5","move 2 from 9 to 6","move 1 from 2 to 1","move 7 from 2 to 3","move 7 from 8 to 1","move 2 from 6 to 3","move 1 from 4 to 6","move 2 from 8 to 6","move 10 from 3 to 9","move 18 from 5 to 8","move 1 from 4 to 6","move 2 from 1 to 9","move 12 from 6 to 9","move 1 from 6 to 9","move 9 from 8 to 4","move 6 from 1 to 2","move 3 from 8 to 9","move 14 from 9 to 8","move 5 from 4 to 9","move 2 from 4 to 5","move 16 from 8 to 5","move 12 from 5 to 4","move 7 from 5 to 1","move 1 from 1 to 8","move 1 from 5 to 8","move 1 from 4 to 9","move 8 from 2 to 7","move 12 from 4 to 3","move 2 from 2 to 5","move 1 from 3 to 2","move 3 from 5 to 4","move 1 from 4 to 8","move 3 from 4 to 9","move 18 from 9 to 8","move 8 from 3 to 1","move 5 from 8 to 1","move 1 from 2 to 5","move 3 from 7 to 1","move 3 from 7 to 5","move 1 from 8 to 9","move 5 from 9 to 7","move 2 from 3 to 6","move 16 from 1 to 4","move 14 from 8 to 6","move 2 from 5 to 6","move 4 from 1 to 6","move 3 from 4 to 9","move 15 from 6 to 1","move 5 from 4 to 3","move 2 from 8 to 2","move 6 from 4 to 3","move 15 from 1 to 5","move 14 from 5 to 3","move 5 from 6 to 2","move 2 from 4 to 7","move 1 from 1 to 6","move 2 from 3 to 4","move 3 from 8 to 1","move 1 from 5 to 1","move 5 from 7 to 1","move 7 from 1 to 3","move 3 from 6 to 2","move 4 from 9 to 5","move 2 from 4 to 3","move 4 from 7 to 9","move 8 from 2 to 9","move 1 from 9 to 1","move 2 from 2 to 8","move 11 from 9 to 1","move 6 from 5 to 1","move 21 from 3 to 2","move 1 from 8 to 5","move 5 from 1 to 7","move 12 from 1 to 8","move 1 from 5 to 2","move 5 from 3 to 2","move 4 from 7 to 2","move 1 from 7 to 8","move 13 from 2 to 5","move 13 from 2 to 5","move 2 from 2 to 1","move 1 from 1 to 9","move 26 from 5 to 4","move 3 from 2 to 7","move 2 from 3 to 9","move 1 from 1 to 6","move 5 from 3 to 2","move 2 from 9 to 6","move 1 from 1 to 8","move 3 from 1 to 6","move 24 from 4 to 9","move 13 from 9 to 1","move 2 from 6 to 2","move 3 from 7 to 5","move 2 from 9 to 7","move 8 from 8 to 3","move 4 from 8 to 5","move 2 from 7 to 2","move 8 from 9 to 4","move 10 from 1 to 2","move 1 from 9 to 1","move 1 from 9 to 2","move 4 from 3 to 2","move 4 from 1 to 8","move 3 from 4 to 8","move 12 from 2 to 3","move 3 from 4 to 6","move 5 from 3 to 2","move 9 from 3 to 9","move 4 from 2 to 9","move 1 from 3 to 7","move 6 from 8 to 2","move 4 from 6 to 8","move 1 from 3 to 8","move 6 from 9 to 1","move 2 from 1 to 8","move 5 from 5 to 8","move 3 from 6 to 8","move 1 from 5 to 1","move 7 from 8 to 2","move 1 from 1 to 4","move 1 from 4 to 6","move 1 from 9 to 4","move 1 from 5 to 9","move 1 from 4 to 7","move 12 from 8 to 2","move 4 from 4 to 3","move 2 from 3 to 1","move 1 from 7 to 2","move 1 from 6 to 8","move 1 from 8 to 6","move 4 from 9 to 3","move 1 from 9 to 3","move 13 from 2 to 3","move 3 from 1 to 7","move 2 from 9 to 4","move 2 from 1 to 9","move 2 from 7 to 2","move 1 from 4 to 1","move 2 from 7 to 5","move 14 from 3 to 8","move 1 from 8 to 5","move 2 from 1 to 4","move 2 from 3 to 4","move 2 from 3 to 4","move 10 from 8 to 3","move 2 from 4 to 8","move 1 from 9 to 3","move 3 from 2 to 3","move 16 from 2 to 4","move 1 from 8 to 5","move 11 from 3 to 4","move 2 from 3 to 7","move 3 from 5 to 1","move 1 from 1 to 2","move 3 from 2 to 5","move 1 from 1 to 9","move 2 from 7 to 4","move 8 from 4 to 3","move 1 from 6 to 7","move 1 from 8 to 6","move 1 from 5 to 1","move 6 from 3 to 5","move 2 from 1 to 3","move 5 from 5 to 7","move 2 from 7 to 2","move 2 from 3 to 4","move 4 from 7 to 1","move 1 from 6 to 8","move 1 from 2 to 1","move 3 from 1 to 6","move 2 from 9 to 6","move 8 from 2 to 1","move 2 from 6 to 2","move 2 from 6 to 3","move 6 from 3 to 5","move 2 from 4 to 6","move 2 from 2 to 9","move 1 from 8 to 6","move 2 from 6 to 5","move 1 from 9 to 1","move 11 from 5 to 8","move 7 from 8 to 6","move 23 from 4 to 1","move 1 from 5 to 9","move 1 from 4 to 6","move 2 from 4 to 8","move 1 from 3 to 1","move 6 from 8 to 3","move 2 from 9 to 6","move 3 from 6 to 1","move 3 from 8 to 7","move 1 from 3 to 6","move 18 from 1 to 2","move 5 from 3 to 8","move 13 from 2 to 9","move 5 from 9 to 7","move 1 from 8 to 6","move 5 from 2 to 6","move 2 from 1 to 7","move 9 from 7 to 8","move 11 from 8 to 6","move 2 from 9 to 4","move 16 from 6 to 1","move 2 from 4 to 6","move 1 from 8 to 9","move 1 from 7 to 6","move 8 from 1 to 5","move 3 from 6 to 5","move 8 from 6 to 4","move 7 from 9 to 5","move 1 from 8 to 1","move 6 from 5 to 1","move 9 from 5 to 7","move 4 from 7 to 9","move 1 from 4 to 8","move 1 from 8 to 3","move 1 from 1 to 8","move 1 from 8 to 7","move 22 from 1 to 3","move 1 from 6 to 7","move 2 from 9 to 4","move 1 from 9 to 6","move 1 from 9 to 4","move 10 from 4 to 3","move 1 from 1 to 2","move 2 from 5 to 4","move 27 from 3 to 8","move 5 from 3 to 9",]
  end
end



Day5.run()
