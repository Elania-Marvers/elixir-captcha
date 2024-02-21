defmodule Captcha do
  # allow customize receive timeout, default: 10_000
  def get(timeout \\ 10_000) do
    Port.open({:spawn, Path.join(:code.priv_dir(:captcha), "captcha")}, [:binary])
    IO.inspect("GENERATING CAPTCHA WITH #{timeout} ms")
    # Allow set receive timeout
    receive do
      {_, {:data, data}} ->
        
        <<text::bytes-size(5), img::binary>> = data

        if img == "" do
          IO.inspect("regenerating captchat")
          get()
        else
        IO.inspect("SUCESS { OK | #{text} | #{img} } ")
          {:ok, text, img }
        end



      other -> other
    after timeout ->
      IO.inspect("TIMEOUT")
      {:timeout}
    end
  end
end
