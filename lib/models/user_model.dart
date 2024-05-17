class ChatUser {
  ChatUser({
    required this.image,
    required this.pushToken,
    required this.about,
    required this.name,
    required this.isOnline,
    required this.id,
    required this.lastactive,
    required this.email,
  });

  late final String image;
  late final String pushToken;
  late final String about;
  late final String name;
  late final bool isOnline;
  late final String id;
  late final String lastactive;
  late final String email;

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    pushToken = json['push Token'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    isOnline = json['isOnline'] ?? '';
    id = json['id'] ?? '';
    lastactive = json['last active'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['push Token'] = pushToken;
    data['about'] = about;
    data['name'] = name;
    data['isOnline'] = isOnline;
    data['id'] = id;
    data['last active'] = lastactive;
    data['email'] = email;
    return data;
  }
}
