defmodule WithOnnx do
  @moduledoc """
  Helper module from ONNX to Axon.
  """

  @doc """
  Loads an ONNX model into Axon and saves the model

  ## Examples

      iex> OnnxToAxon.onnx_axon(path_to_onnx_file, path_to_axon_dir)

  """
  def onnx_axon(path_to_onnx_file, path_to_axon_dir) do
    axon_name = axon_name_from_onnx_path(path_to_onnx_file)
    path_to_axon = Path.join(path_to_axon_dir, axon_name)

    {model, parameters} = AxonOnnx.import(path_to_onnx_file)
    model_bytes = Axon.serialize(model, parameters)
    IO.puts(path_to_axon)
    File.write!(path_to_axon, model_bytes)
  end

  defp axon_name_from_onnx_path(onnx_path) do
    model_root = onnx_path |> Path.basename() |> Path.rootname()
    "#{model_root}.axon"
  end
end
