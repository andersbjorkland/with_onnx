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

  defp get_onnx_model(path_to_onnx_file) do
    AxonOnnx.import(path_to_onnx_file)
  end

  defp axon_name_from_onnx_path(onnx_path) do
    model_root = onnx_path |> Path.basename() |> Path.rootname()
    "#{model_root}.axon"
  end

  def analyze_cats_v_dogs(cats_v_dogs_path) do

    data_path = "data";
    images = "data/cat_v_dog/*.jpg"
      |> Path.wildcard()

    resized_images =
      Enum.map(images, fn file_name ->
        IO.inspect(file_name, label: file_name)
        |> StbImage.read_file!()
        |> StbImage.resize(224, 224)
      end)

    img_tensors =
      resized_images
      |> Enum.map(&StbImage.to_nx/1)
      |> Nx.stack(name: :index)
      |> Nx.divide(255.0)
      |> Nx.transpose(axes: [:index, :channels, :height, :width])

    cats_v_dogs = File.read!(cats_v_dogs_path)
    # If Axon model has been stored as a file, load it with this code
    # BUT, this way will be deprecated in future release of Axon
    # {cats_v_dogs_model, cats_v_dogs_params} = Axon.deserialize(cats_v_dogs)

    # Another alternative is to load the ONNX-model
    {cats_v_dogs_model, cats_v_dogs_params} = get_onnx_model(cats_v_dogs_path)

    tensor_of_predictions =
      Axon.predict(cats_v_dogs_model, cats_v_dogs_params, img_tensors, compiler: EXLA)

    dog_cat_vocabulary = [
      "dog",
      "cat"
    ]

    Predictions.single_label_classification(tensor_of_predictions, dog_cat_vocabulary)
  end
end
