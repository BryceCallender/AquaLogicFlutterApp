import 'dart:convert';

class Display {
  List<DisplaySection>? displaySections;

  Display({this.displaySections});

  factory Display.fromJson(Map<String, dynamic> json) {
    var sections = json['displaySections'] as List;
    return Display(
      displaySections: sections.map((ds) => DisplaySection.fromJson(ds)).toList()
    );
  }
}

class DisplaySection {
  String? content;
  bool? blinking;
  int? displayRow;

  DisplaySection({this.content, this.blinking, this.displayRow});

  factory DisplaySection.fromJson(Map<String, dynamic> json) {
    return DisplaySection(
        content: json['content'],
        blinking: json['blinking'],
        displayRow: json['displayRow'],
    );
  }
}
