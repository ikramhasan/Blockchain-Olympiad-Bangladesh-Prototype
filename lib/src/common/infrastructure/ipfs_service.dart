import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:ipfs_client_flutter/ipfs_client_flutter.dart';
import 'package:nfc/src/common/domain/failure.dart';
import 'package:nfc/src/common/infrastructure/file_picker_service.dart';

class IPFSService {
  final _filePickerService = FilePickerService();
  final _ipfsClient = IpfsClient();

  IPFSService();

  Future<Either<Failure, ProfilePhoto>> pickImageAndSaveToIPFS() async {
    final failureOrFile = await _filePickerService.pickImageFile();

    return failureOrFile.fold(
      (l) => left(l),
      (profilePhoto) async {
        final fileName = DateTime.now().toString() + ' - ' + profilePhoto.name;

        final response = await _ipfsClient.write(
          dir: '/nfc_profile/$fileName',
          filePath: profilePhoto.path.replaceAll('\\', '//'),
          fileName: fileName,
        );

        return right(
          ProfilePhoto(
            name: fileName,
            path: profilePhoto.path,
            bytes: profilePhoto.bytes,
          ),
        );
      },
    );
  }

  Future<Uint8List> readFile(String fileName) async {
    var response = await _ipfsClient.read(
      dir: "/nfc_profile/$fileName",
    );

    print(response);

    return response['data'] as Uint8List;
  }
}
