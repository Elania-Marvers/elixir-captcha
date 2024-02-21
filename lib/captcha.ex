defmodule Captcha do
  # allow customize receive timeout, default: 10_000
  def get(timeout \\ 10_000) do
    Port.open({:spawn, Path.join(:code.priv_dir(:captcha), "captcha")}, [:binary])
    IO.inspect("GENERATING CAPTCHA WITH #{timeout} ms")
    # Allow set receive timeout
    receive do
      {_, {:data, data}} ->
        IO.inspect("SUCESS")
        <<text::bytes-size(5), img::binary>> = data
        {:ok, text, img }

      other -> other
    after timeout ->
      IO.inspect("TIMEOUT")
      {:timeout}
    end
  end
end
