defmodule ConvertModel do
  def load(path_to_onnx_file) do
    #path_to_onnx_file = "models/onnx/cats_v_dogs.onnx"
    path_to_axon_dir = "/models/axon"

    #File.write!("models/tmp.txt", path_to_axon_dir)

    WithOnnx.onnx_axon(path_to_onnx_file, path_to_axon_dir)
  end
end
