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
    imageLib.Image img = imageLib.Image.fromBytes(cameraImage.planes[0].width!,
        cameraImage.planes[0].height!, cameraImage.planes[0].bytes,
        format: imageLib.Format.bgra);
    return img;
  }
}
