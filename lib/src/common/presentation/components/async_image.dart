import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc/src/common/infrastructure/ipfs_service.dart';
import 'package:nfc/src/common/presentation/components/loading_widget.dart';

class AsyncImage extends StatelessWidget {
  const AsyncImage({
    Key? key,
    required this.url,
    this.radius,
  }) : super(key: key);

  final String url;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: IPFSService().readFile(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 50,
            width: 50,
            child: LoadingWidget(),
          );
        } else {
          return CircleAvatar(
            radius: radius,
            backgroundImage: MemoryImage(snapshot.data!),
          );
        }
      },
    );
  }
}
