# WithOnnx
Project following tutorial on how to load an external model into Axon.

Add cats and dogs to data to `./data`, update filenames accordingly in `./lib/with_onnx.ex`

Example on how to run an analysis:
`WithOnnx.analyze_cats_v_dogs("models/onnx/cats_v_dogs.onnx")`

Get ONNX model for cats v dogs from https://huggingface.co/ScottMueller/Cats_v_Dogs.ONNX/tree/main and put it in a 
good place, such as `./models/onnx` and use its path like this 
`WithOnnx.analyze_cats_v_dogs("models/axon/cats_v_dogs.axon")`