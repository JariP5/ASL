    // // Get expected input shape
    // final expectedInputShape = _interpreter!.getInputTensor(0).shape;

    // // Get expected output shape
    // final expectedOutputShape = _interpreter!.getOutputTensor(0).shape;

    // // Check input shape
    // if (inputs.shape != expectedInputShape) {
    //   print('Input shape does not match expected shape: '
    //       'expected $expectedInputShape but got ${inputs.shape}');
    // }

    // // Check output shape
    // if (_outputShapes![0].shape != expectedOutputShape) {
    //   print('Output shape does not match expected shape: '
    //       'expected $expectedOutputShape but got ${_outputShapes![0].shape}');
    // }

    // flutter: Input shape does not match expected shape: expected [1, 28, 28, 1] but got [1]
    // flutter: Output shape does not match expected shape: expected [1, 25] but got [2]

 // Define a function to convert a BGRA8888 image to grayscale
//  static Uint8List bgraToGrayscale(Uint8List bgraData, int width, int height) {
//   // Allocate a new array to store the grayscale data
//   Uint8List grayData = Uint8List(width * height);

//   // Iterate through each pixel in the image
//   for (int y = 0; y < height; y++) {
//     for (int x = 0; x < width; x++) {
//       // Calculate the offset of the current pixel in the BGRA data
//       int offset = (y * width + x) * 4;

//       // Extract the blue, green, and red components of the pixel
//       int blue = bgraData[offset];
//       int green = bgraData[offset + 1];
//       int red = bgraData[offset + 2];

//       // Calculate the grayscale value of the pixel (using the luminance method)
//       int gray = (0.2126 * red + 0.7152 * green + 0.0722 * blue).round();

//       // Store the grayscale value in the output array
//       grayData[y * width + x] = gray;
//     }
//   }

//   // Return the grayscale image data
//   return grayData;
// }