

import 'package:messenger/Repository/DBHelper.dart';

class Messages{
  int key;
  int chatkey=0;
  String message;
  String sender=DBHelper.auth.currentUser!.uid;
  bool isImage;
  bool isAudio;
  String link;

//<editor-fold desc="Data Methods">

  Messages({
    required this.key,
    required this.message,
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
      key: key??this.key,
      message: message ?? this.message,
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
      key: map['key'] as int,
      message: map['message'] as String,
      isImage: map['isImage'] as bool,
      isAudio: map['isAudio'] as bool,
      link: map['link'] as String,
    );
  }

//</editor-fold>
}