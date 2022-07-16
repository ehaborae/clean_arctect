class TranslationModel {
  late String access;

  TranslationModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
  }
}
