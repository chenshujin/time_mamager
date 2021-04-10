extension StringCommonExtension on String {
  String get webP {
    return "assets/images/${_appendSuffix(this, 'webp')}";
  }

  String get png {
    return "assets/images/${_appendSuffix(this, 'png')}";
  }

  String get jpg {
    return "assets/images/${_appendSuffix(this, 'jpg')}";
  }

  String get json {
    return "assets/json/${_appendSuffix(this, 'json')}";
  }
}

String _appendSuffix(String fileName, String suffix) {
  if (fileName.indexOf(".") > 0) {
    return fileName;
  }
  return '$fileName.$suffix';
}
