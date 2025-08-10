import 'dart:async';
import 'dart:io';
import 'package:disk_space_update/disk_space_update.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Storagecheck extends StatefulWidget {
  const Storagecheck({super.key});

  @override
  State<Storagecheck> createState() => _StoragecheckState();
}

class _StoragecheckState extends State<Storagecheck> {
  double _diskSpace = 0;

  @override
  void initState() {
    super.initState();
    initDiskSpace();
  }

  Future<void> initDiskSpace() async {
    double diskSpace = 0;

    diskSpace = await DiskSpace.getFreeDiskSpace ?? 0;

    List<Directory> directories;
    Map<Directory, double> directorySpace = {};

    if (Platform.isIOS) {
      directories = [await getApplicationDocumentsDirectory()];
    } else if (Platform.isAndroid) {
      directories =
          await getExternalStorageDirectories(
            type: StorageDirectory.movies,
          ).then(
            (list) async => list ?? [await getApplicationDocumentsDirectory()],
          );
    } else {
      return;
    }

    for (var directory in directories) {
      var space = await DiskSpace.getFreeDiskSpaceForPath(directory.path) ?? 0;
      directorySpace.addEntries([MapEntry(directory, space)]);
    }

    if (!mounted) return;

    setState(() {
      _diskSpace = diskSpace / 1024;
    });
  }

  @override
  Widget build(BuildContext context) {
    String space = _diskSpace.toStringAsFixed(2);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(child: Text('Available Space on device (GB): $space\n')),
      ),
    );
  }
}
