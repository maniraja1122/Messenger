

class CallLog{
  int key=DateTime.now().microsecondsSinceEpoch;
  String user1;
  String user2;
  bool isFirstCaller;

//<editor-fold desc="Data Methods">

  CallLog({
    required this.user1,
    required this.user2,
    required this.isFirstCaller,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CallLog &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          user1 == other.user1 &&
          user2 == other.user2 &&
          isFirstCaller == other.isFirstCaller);

  @override
  int get hashCode =>
      key.hashCode ^ user1.hashCode ^ user2.hashCode ^ isFirstCaller.hashCode;

  @override
  String toString() {
    return 'CallLog{' +
        ' key: $key,' +
        ' user1: $user1,' +
        ' user2: $user2,' +
        ' isFirstCaller: $isFirstCaller,' +
        '}';
  }

  CallLog copyWith({
    int? key,
    String? user1,
    String? user2,
    bool? isFirstCaller,
  }) {
    return CallLog(
      user1: user1 ?? this.user1,
      user2: user2 ?? this.user2,
      isFirstCaller: isFirstCaller ?? this.isFirstCaller,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'user1': this.user1,
      'user2': this.user2,
      'isFirstCaller': this.isFirstCaller,
    };
  }

  factory CallLog.fromMap(Map<String, dynamic> map) {
    return CallLog(
      user1: map['user1'] as String,
      user2: map['user2'] as String,
      isFirstCaller: map['isFirstCaller'] as bool,
    );
  }

//</editor-fold>
}