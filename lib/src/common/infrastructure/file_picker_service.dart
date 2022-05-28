import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nfc/src/common/domain/failure.dart';

class FilePickerService {
  Future<Either<Failure, ProfilePhoto>> pickImageFile() async {
    final pickedImage = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (pickedImage == null) {
      return left(
        Failure(
          message: 'Please pick a file to proceed',
          code: 708,
        ),
      );
    } else {
      final file = pickedImage.files.first;
      if (file.path == null) {
        return left(
          Failure(
            message: 'Could not get the file path. Try again!',
            code: 890,
          ),
        );
      } else {
        return right(
          ProfilePhoto(name: file.name, path: file.path!),
        );
      }
    }
  }
}

class ProfilePhoto {
  final String name;
  final String path;
  final Uint8List? bytes;

  ProfilePhoto({
    required this.name,
    required this.path,
    this.bytes,
  });
}
