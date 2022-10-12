class UserModelData {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UserModelData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  UserModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    email = json['email']?.toString();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    avatar = json['avatar']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}

class UserModel {
  List<UserModelData?>? data;

  UserModel({
    this.data,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      final v = json['users'];
      final arr0 = <UserModelData>[];
      v.forEach((v) {
        arr0.add(UserModelData.fromJson(v));
      });
      data = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['users'] = arr0;
    }
    return data;
  }
}
