class UploadedImage {
  final String fileName;
  final String s3URL;

  UploadedImage({required this.fileName, required this.s3URL});

  Map<String, dynamic> toJSON() {
    return {
      "name": fileName,
      "url": s3URL,
    };
  }
}
