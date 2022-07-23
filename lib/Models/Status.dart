
class Status{
  int key;
  String userkey;
  String link;

//<editor-fold desc="Data Methods">

  Status({
    required this.key,
    required this.userkey,
    required this.link,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Status &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          userkey == other.userkey &&
          link == other.link);

  @override
  int get hashCode => key.hashCode ^ userkey.hashCode ^ link.hashCode;

  @override
  String toString() {
    return 'Status{' +
        ' key: $key,' +
        ' userkey: $userkey,' +
        ' link: $link,' +
        '}';
  }

  Status copyWith({
    int? key,
    String? userkey,
    String? link,
  }) {
    return Status(
      key: key ?? this.key,
      userkey: userkey ?? this.userkey,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'userkey': this.userkey,
      'link': this.link,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      key: map['key'] as int,
      userkey: map['userkey'] as String,
      link: map['link'] as String,
    );
  }

//</editor-fold>
}