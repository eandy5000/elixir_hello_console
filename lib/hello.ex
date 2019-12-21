defmodule Hello do
  defstruct(
    name: nil,
    error: nil
  )

  @greeting " Hello "

  def run() do
    %Hello{} |> run()
  end

  def run(:quit), do: :quit

  def run(hello = %Hello{}) do
    [
      hack_clear()
    ]
    |> IO.write()

    hello
    |> view()
    |> IO.write()

    hello = %{hello | error: nil}
    cmd = IO.gets(" > ")

    hello
    |> update(cmd)
    |> run()

  end

  def update(hello, cmd) when is_binary(cmd) do
    update(hello, String.split(cmd))
  end

  def update(hello, ["a" <> _]) do
    hello_again = @greeting <> hello.name
    %{hello | name: hello_again}
  end

  def update(hello, ["n" <> _ ]) do
    %{hello | error: "Invalid Name: enter name"}
  end

  def update(hello, ["n" <> _ | args]) do
    name = Enum.join(args, " ")
    %{hello | name: @greeting <> name}
  end

  def update(_hello, ["q" <> _]), do: :quit

  def update(hello, _error) do
    %{hello | error: "Invalid command"}
  end

  def view(hello) do
    [
      view_error(hello.error),
      view_greeting(hello.name),
      view_commands(hello)
    ]
  end

  def view_greeting(name) when is_nil(name) do
    [
      "Enter Name",
      "\n"
    ]
  end

  def view_greeting(name) do
    [
      "#{name}",
      "\n"
    ]
  end

  def view_error(error) when is_nil(error) do
    []
  end

  def view_error(error) do
    [
      "ERROR: #{error}",
      "\n"
    ]
  end

  def view_commands(%{name: nil} = _hello) do
    [
      "(n)ame <name> (q)uit",
      "\n"
    ]
  end

  def view_commands(_hello) do
    [
      "(a)gain (q)uit",
      "\n"
    ]
  end

  def hack_clear() do
    "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
  end


end
