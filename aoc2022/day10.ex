defmodule Day10 do
  def run do
    IO.puts(execute(input, 1,1,2,0,21))
    part2(input,1,1,2,%{})
  end

  def execute(ins, regX, cycle, repeat, sum, sigCycle) do
    tuple = regSum(regX, cycle, sigCycle,sum)
    nSum = elem(tuple, 0)
    nSigCyle = elem(tuple, 1)

    cond do
      length(ins) == 0 -> nSum
      hd(ins) == "noop" ->
        execute(tl(ins), regX, cycle+1, 2, nSum, nSigCyle)
      repeat > 0 ->
        execute(ins, regX, cycle+1, repeat-1, nSum,nSigCyle)
      true ->
        execute(tl(ins), addX(hd(ins),regX), cycle, 2, nSum, nSigCyle)
    end
  end

  def part2(ins, regX, cycle, repeat, printedPos) do
    cond do
      length(ins) == 0 -> "end"
      hd(ins) == "noop" ->
        nPrintedPos = printRegX(regX, cycle, printedPos)
        part2(tl(ins), regX, cycle+1, 2, nPrintedPos)
      repeat > 1 ->
        nPrintedPos = printRegX(regX, cycle, printedPos)
        part2(ins, regX, cycle+1, repeat-1, printedPos)
      true ->
        nPrintedPos = printRegX(addX(hd(ins),regX), cycle, printedPos)
        part2(tl(ins), addX(hd(ins),regX), cycle+1, 2, nPrintedPos)
    end
  end

  def printRegX(regX, cycle,printedPos) do
    linePos = rem(cycle,40)
    #line = div(cycle, 40)
    cond do
      Map.get(printedPos, cycle, false) == true ->
        printedPos
      abs(regX - linePos)<2 ->
        if linePos == 0 do
          IO.write("\n")
        end
        IO.write("#")
        Map.put(printedPos, cycle, true)
      true ->
        if linePos == 0 do
          IO.write("\n")
        end
        IO.write(".")
        Map.put(printedPos, cycle, true)
    end
  end

  def regSum(regX, cycle, sigCycle, sum) do
    if cycle == sigCycle do
      # IO.puts("---cycle---")
      # #IO.inspect(ins)
      # IO.inspect(regX)
      # IO.inspect(cycle)
      # #IO.inspect(repeat)
      # IO.inspect((cycle-1)*regX)
      # IO.inspect(sum + (cycle-1)*regX)
      # IO.puts("-----------")
      {sum + (cycle-1)*regX, sigCycle+40}
    else
      {sum, sigCycle}
   end
  end

  def addX(ins, regX) do
    insValue = String.split(ins, " ") |> Enum.at(1) |> Integer.parse() |> elem(0)
    regX + insValue
  end

  def inputMini do
    [
      "noop",
      "addx 3",
      "addx -5",
    ]
  end

  def inputEX do
    ["addx 15","addx -11","addx 6","addx -3","addx 5","addx -1","addx -8","addx 13","addx 4","noop","addx -1","addx 5","addx -1","addx 5","addx -1","addx 5","addx -1","addx 5","addx -1","addx -35","addx 1","addx 24","addx -19","addx 1","addx 16","addx -11","noop","noop","addx 21","addx -15","noop","noop","addx -3","addx 9","addx 1","addx -3","addx 8","addx 1","addx 5","noop","noop","noop","noop","noop","addx -36","noop","addx 1","addx 7","noop","noop","noop","addx 2","addx 6","noop","noop","noop","noop","noop","addx 1","noop","noop","addx 7","addx 1","noop","addx -13","addx 13","addx 7","noop","addx 1","addx -33","noop","noop","noop","addx 2","noop","noop","noop","addx 8","noop","addx -1","addx 2","addx 1","noop","addx 17","addx -9","addx 1","addx 1","addx -3","addx 11","noop","noop","addx 1","noop","addx 1","noop","noop","addx -13","addx -19","addx 1","addx 3","addx 26","addx -30","addx 12","addx -1","addx 3","addx 1","noop","noop","noop","addx -9","addx 18","addx 1","addx 2","noop","noop","addx 9","noop","noop","noop","addx -1","addx 2","addx -37","addx 1","addx 3","noop","addx 15","addx -21","addx 22","addx -6","addx 1","noop","addx 2","addx 1","noop","addx -10","noop","noop","addx 20","addx 1","addx 2","addx 2","addx -6","addx -11","noop","noop","noop",
    ]
  end

  def input do
    ["addx 1","noop","addx 4","noop","noop","noop","addx 6","addx -1","addx 5","noop","noop","noop","addx 5","addx -14","noop","addx 19","noop","addx 1","addx 4","addx 1","noop","noop","addx 2","addx 5","addx -27","addx 20","addx -30","addx 2","addx 5","addx 2","addx 4","addx -3","addx 2","addx 5","addx 2","addx -9","addx 1","addx 11","noop","addx -20","addx 7","addx 23","addx 2","addx 3","addx -2","addx -34","addx -2","noop","addx 3","noop","addx 3","addx 2","noop","addx 3","addx 2","addx 5","addx 2","addx -9","addx -7","addx 21","noop","addx 8","noop","addx -1","addx 3","addx -2","addx 5","addx -37","noop","addx 35","addx -31","addx 1","addx 4","addx -1","addx 2","noop","addx 3","addx 1","addx 5","addx -2","addx 7","addx -2","addx -2","addx 10","noop","addx 4","noop","noop","addx -19","addx 20","addx -38","noop","noop","addx 7","addx 2","addx 3","noop","addx 4","addx -3","addx 2","addx 2","noop","addx 3","noop","noop","noop","addx 5","noop","addx 7","addx -2","addx 7","noop","noop","addx -5","addx 6","addx -36","noop","addx 1","addx 2","addx 5","addx 2","addx 3","addx -2","addx 2","addx 5","addx 2","addx 1","noop","addx 4","addx -16","addx 21","noop","noop","addx 1","addx -8","addx 12","noop","noop","noop","noop",]
  end
end

Day10.run()
