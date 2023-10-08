import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Downloader extends StatefulWidget {
  const Downloader({super.key});

  @override
  State<Downloader> createState() => _DownloaderState();
}

class _DownloaderState extends State<Downloader> {
  final ReceivePort _port = ReceivePort();
  FirebaseStorage storage = FirebaseStorage.instance;

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int downloadProgress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, downloadProgress]);
  }

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Download"),
        onPressed: () async {
          // final userCredential =
          //     await FirebaseAuth.instance.signInAnonymously();
          String dir = (await getApplicationDocumentsDirectory()).path;
          debugPrint("getApplicationDocumentsDirectory(): ${dir}");
          Reference ref = storage.ref().child('test.pdf');
          String url = await ref.getDownloadURL();

          await FlutterDownloader.enqueue(
            url: url,
            savedDir: dir,
            fileName: 'testFile',
            saveInPublicStorage: true,
            showNotification: true,
            openFileFromNotification: true,
          );
          //final tasks = await FlutterDownloader.loadTasks();
        },
      ),
    );
  }
}
