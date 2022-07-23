
class Users{
String key="";
String name="";
String email="";
String password="";
String dplink="";
bool isActive=true;
int lastSeen=DateTime.now().microsecondsSinceEpoch;

//<editor-fold desc="Data Methods">

  Users({
    required this.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Users &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          dplink == other.dplink &&
          isActive == other.isActive &&
          lastSeen == other.lastSeen);

  @override
  int get hashCode =>
      key.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      dplink.hashCode ^
      isActive.hashCode ^
      lastSeen.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' key: $key,' +
        ' name: $name,' +
        ' email: $email,' +
        ' password: $password,' +
        ' dplink: $dplink,' +
        ' isActive: $isActive,' +
        ' lastSeen: $lastSeen,' +
        '}';
  }

  Users copyWith({
    String? key,
    String? name,
    String? email,
    String? password,
    String? dplink,
    bool? isActive,
    int? lastSeen,
  }) {
    return Users(
      key: key ?? this.key,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': this.key,
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'dplink': this.dplink,
      'isActive': this.isActive,
      'lastSeen': this.lastSeen,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      key: map['key'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

//</editor-fold>
}