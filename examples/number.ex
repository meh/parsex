defmodule Number do
  use Parsex

  rule :digit! do
    match("[1-9]")
  end

  rule :digit do
    match("[0-9]")
  end

  rule :number do
    ^(digit! |> repeat(digit))
  end

  root :number
end
