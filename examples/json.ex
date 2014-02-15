defmodule JSON do
  use Parsex

  rule :spaces do
    match("\s") |> repeat(1)
  end

  rule :spaces? do
    spaces |> maybe
  end

  rule :comma do
    spaces? |> match(",") |> spaces?
  end
end
