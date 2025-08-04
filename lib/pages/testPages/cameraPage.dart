import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:open_file/open_file.dart';

class AwesomeCameraPage extends StatefulWidget {
  const AwesomeCameraPage({super.key});

  @override
  State<AwesomeCameraPage> createState() => _AwesomeCameraPageState();
}

class _AwesomeCameraPageState extends State<AwesomeCameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Awesome Camera')),
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photoAndVideo(),
        // onMediaTap: (mediaCapture) async {
        //   final file = await mediaCapture.captureRequest.savedFile;
        //   final path = file?.path;
        //
        //   if (path != null) {
        //     OpenFile.open(path);
        //   } else {
        //     if (mounted) {
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text("File not available yet.")),
        //       );
        //     }
        //   }
        // },
        onMediaTap: (mediaCapture) async {
          print('MediaCapture: $mediaCapture');
          print(
            'CaptureRequest type: ${mediaCapture.captureRequest.runtimeType}',
          );
          final r = mediaCapture.captureRequest;
          print('Available fields on request: ${r.toString()}');
        },
      ),
    );
  }
}
