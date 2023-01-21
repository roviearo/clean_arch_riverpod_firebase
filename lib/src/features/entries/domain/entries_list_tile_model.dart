// ignore_for_file: public_member_api_docs, sort_constructors_first
class EntriesListTileModel {
  EntriesListTileModel({
    required this.leadingText,
    required this.trailingText,
    this.middleText,
    required this.isHeader,
  });

  final String leadingText;
  final String trailingText;
  final String? middleText;
  final bool isHeader;
}
