import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

import 'firebase_options.dart';

class FirebaseInit {

  FirebaseInit();

  static Future<String> downloadModel() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseModelDownloader.instance
      .getModel(
          "LiteModel",
          FirebaseModelDownloadType.localModel,
          FirebaseModelDownloadConditions(
            iosAllowsCellularAccess: true,
            iosAllowsBackgroundDownloading: false,
            androidChargingRequired: false,
            androidWifiRequired: false,
            androidDeviceIdleRequired: false,
          )
      )
      .then((customModel) {
        // Download complete. Depending on your app, you could enable the ML
        // feature, or switch from the local model to the remote model, etc.

        // The CustomModel object contains the local path of the model file,
        // which you can use to instantiate a TensorFlow Lite interpreter.
        return customModel.file.path;
      });
    return "";
  }
}

