
class Chats{
  int chatkey=DateTime.now().microsecondsSinceEpoch;
  String user1="";
  String user2="";
  int lastSend=DateTime.now().microsecondsSinceEpoch;

//<editor-fold desc="Data Methods">

  Chats({
    required this.user1,
    required this.user2,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chats &&
          runtimeType == other.runtimeType &&
          chatkey == other.chatkey &&
          user1 == other.user1 &&
          user2 == other.user2 &&
          lastSend == other.lastSend);

  @override
  int get hashCode =>
      chatkey.hashCode ^ user1.hashCode ^ user2.hashCode ^ lastSend.hashCode;

  @override
  String toString() {
    return 'Chats{' +
        ' chatkey: $chatkey,' +
        ' user1: $user1,' +
        ' user2: $user2,' +
        ' lastSend: $lastSend,' +
        '}';
  }

  Chats copyWith({
    int? chatkey,
    String? user1,
    String? user2,
    int? lastSend,
  }) {
    return Chats(
      user1: user1 ?? this.user1,
      user2: user2 ?? this.user2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatkey': this.chatkey,
      'user1': this.user1,
      'user2': this.user2,
      'lastSend': this.lastSend,
    };
  }

  factory Chats.fromMap(Map<String, dynamic> map) {
    return Chats(
      user1: map['user1'] as String,
      user2: map['user2'] as String,
    );
  }

//</editor-fold>
}