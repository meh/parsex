defmodule Parsex do
  defmacro __using__(_opts) do
    quote do
      import          unquote(__MODULE__)
      @before_compile unquote(__MODULE__)

      @rules []
    end
  end

  defmacro __before_compile__(_env) do
    quote unquote: false do
      Enum.each @rules, fn { name, body } ->
        def unquote(name)(string) do
          unquote(Parsex.Compiler.compile(body, @rules))
        end
      end

      def rules do
        @rules
      end

      def parse(string) do
        case unquote(@root)(string) do
          { _offset, result } ->
            result
        end
      end
    end
  end

  defmacro rule(name, do: body) do
    quote do
      @rules Dict.put(@rules, unquote(name), unquote(Macro.escape(body)))
    end
  end

  defmacro root(name) do
    quote do
      @root unquote(name)
    end
  end
end
