defmodule Predictions do
  @doc """
  When provided a Tensor of single label predictions, returns the best vocabulary match for
  each row in the prediction tensor.

  ## Examples

      iex> Predictions.sindle_label_prediction(path_to_onnx_file, path_to_axon_dir)
      ["dog", "cat", "dog"]

  """
  def single_label_classification(predictions_batch, vocabulary) do
    IO.inspect(Nx.shape(predictions_batch), label: "predictions batch shape")

    for prediction_tensor <- Nx.to_batched(predictions_batch, 1) do
      {_prediction_value, prediction_label} =
        prediction_tensor
        |> Nx.to_flat_list()
        |> Enum.zip(vocabulary)
        |> Enum.max()

      prediction_label
    end
  end
end