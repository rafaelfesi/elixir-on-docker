defmodule WaterCooler.ChatRoom do
  @default_room :chat

  defmacro post(content) do
    quote do
      {unquote(__MODULE__), unquote(content)}
    end
  end

  def publish(message, room \\ @default_room) do
    :gproc.send({:p, :l, room}, post(message))
    {:ok, message}
  end

  def join(room \\ @default_room) do
    :gproc.reg({:p, :l, room})
    {:ok, room}
  end
end