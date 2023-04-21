import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as imageLib;

/// ImageUtils
class ImageUtils {
  /// Converts a [CameraImage] in YUV420 format to [imageLib.Image] in RGB format
  static imageLib.Image? convertCameraImage(CameraImage cameraImage) {
    if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
      return convertBGRA8888ToImage(cameraImage);
    } else {
      return null;
    }
  }

  /// Converts a [CameraImage] in BGRA888 format to [imageLib.Image] in RGB format
  static imageLib.Image convertBGRA8888ToImage(CameraImage cameraImage) {
    int width = cameraImage.planes[0].width!;
    int height = cameraImage.planes[0].height!;
    Uint8List bgraData = cameraImage.planes[0].bytes;
    Uint8List grayData = bgraToGrayscale(bgraData, width, height);
    imageLib.Image img = imageLib.Image.fromBytes(width, height, grayData,
        format: imageLib.Format.rgb);
    //print(img.channels);
    //print(img.getBytes().length);
    //print(grayData.length);
    return img;
  }

  // Define a function to convert a BGRA8888 image to grayscale
  static Uint8List bgraToGrayscale(Uint8List bgraData, int width, int height) {
    // Allocate a new array to store the grayscale data
    Uint8List grayData = Uint8List(width * height);

    // Iterate through each pixel in the image
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        // Calculate the offset of the current pixel in the BGRA data
        int offset = (y * width + x) * 4;

        // Extract the blue, green, and red components of the pixel
        int blue = bgraData[offset];
        int green = bgraData[offset + 1];
        int red = bgraData[offset + 2];

        // Calculate the grayscale value of the pixel (using the luminance method)
        int gray = (0.2126 * red + 0.7152 * green + 0.0722 * blue).round();

        // Store the grayscale value in the output array
        grayData[y * width + x] = gray;
      }
    }

    // Return the grayscale image data
    return grayData;
  }
}
