class TimeZoneData {
  final String value;
  final String abbr;
  final double offset;
  final bool isdst;
  final String text;
  final List<dynamic> utc;

  TimeZoneData({this.value, this.abbr, this.offset, this.isdst, this.text, this.utc});

  factory TimeZoneData.fromJson(dynamic json) {
    return TimeZoneData(
        value: json['value'] as String,
        abbr: json['abbr'] as String,
        offset: json['offset'] as double,
        isdst: json['isdst'] as bool,
        text: json['text'] as String,
        utc: json['utc'] as List<dynamic>
    );
  }
}