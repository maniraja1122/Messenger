

class Messages{
  int key=DateTime.now().microsecondsSinceEpoch;
  int chatkey;
  String message;
  String sender;
  bool isImage;
  bool isAudio;
  String link;

//<editor-fold desc="Data Methods">

  Messages({
    required this.chatkey,
    required this.message,
    required this.sender,
    required this.isImage,
    required this.isAudio,
    required this.link,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Messages &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          chatkey == other.chatkey &&
          message == other.message &&
          sender == other.sender &&
          isImage == other.isImage &&
          isAudio == other.isAudio &&
          link == other.link);

  @override
  int get hashCode =>
      key.hashCode ^
      chatkey.hashCode ^
      message.hashCode ^
      sender.hashCode ^
      isImage.hashCode ^
      isAudio.hashCode ^
      link.hashCode;

  @override
  String toString() {
    return 'Messages{' +
        ' key: $key,' +
        ' chatkey: $chatkey,' +
        ' message: $message,' +
        ' sender: $sender,' +
        ' isImage: $isImage,' +
        ' isAudio: $isAudio,' +
        ' link: $link,' +
        '}';
  }

  Messages copyWith({
    int? key,
    int? chatkey,
    String? message,
    String? sender,
    bool? isImage,
    bool? isAudio,
    String? link,
  }) {
    return Messages(
      chatkey: chatkey ?? this.chatkey,
      message: message ?? this.message,
      sender: sender ?? this.sender,
      isImage: isImage ?? this.isImage,
      isAudio: isAudio ?? this.isAudio,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'chatkey': this.chatkey,
      'message': this.message,
      'sender': this.sender,
      'isImage': this.isImage,
      'isAudio': this.isAudio,
      'link': this.link,
    };
  }

  factory Messages.fromMap(Map<String, dynamic> map) {
    return Messages(
      chatkey: map['chatkey'] as int,
      message: map['message'] as String,
      sender: map['sender'] as String,
      isImage: map['isImage'] as bool,
      isAudio: map['isAudio'] as bool,
      link: map['link'] as String,
    );
  }

//</editor-fold>
}