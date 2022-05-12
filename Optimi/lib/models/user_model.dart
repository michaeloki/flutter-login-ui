class UserModel {
  User? user;
  bool? success;
  String? hash;
  int? maxQuota;
  int? quotaUsed;
  int? xkv;
  String? storeUrl;
  MaxFileSize? maxFileSize;
  DeviceFeatures? deviceFeatures;
  String? firstname;
  String? surname;

  UserModel({this.user, this.success, this.hash, this.maxQuota, this.quotaUsed, this.xkv, this.storeUrl, this.maxFileSize, this.deviceFeatures, this.firstname, this.surname});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    success = json['success'];
    hash = json['hash'];
    maxQuota = json['maxQuota'];
    quotaUsed = json['quotaUsed'];
    xkv = json['xkv'];
    storeUrl = json['storeUrl'];
    maxFileSize = json['maxFileSize'] != null ? new MaxFileSize.fromJson(json['maxFileSize']) : null;
    deviceFeatures = json['device-features'] != null ? new DeviceFeatures.fromJson(json['device-features']) : null;
    firstname = json['firstname'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['success'] = this.success;
    data['hash'] = this.hash;
    data['maxQuota'] = this.maxQuota;
    data['quotaUsed'] = this.quotaUsed;
    data['xkv'] = this.xkv;
    data['storeUrl'] = this.storeUrl;
    if (this.maxFileSize != null) {
      data['maxFileSize'] = this.maxFileSize!.toJson();
    }
    if (this.deviceFeatures != null) {
      data['device-features'] = this.deviceFeatures!.toJson();
    }
    data['firstname'] = this.firstname;
    data['surname'] = this.surname;
    return data;
  }
}

class User {
  int? userId;
  String? sId;
  String? username;
  String? firstname;
  String? surname;
  bool? enabled;
  Null? email;
  Grants? grants;
  bool? deleted;
  List<String>? groups;
  List<String>? customGroups;
  List<String>? roles;
  String? grade;

  User({this.userId, this.sId, this.username, this.firstname, this.surname, this.enabled, this.email, this.grants, this.deleted, this.groups, this.customGroups, this.roles, this.grade});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    sId = json['_id'];
    username = json['username'];
    firstname = json['firstname'];
    surname = json['surname'];
    enabled = json['enabled'];
    email = json['email'];
    grants = json['grants'] != null ? new Grants.fromJson(json['grants']) : null;
    deleted = json['deleted'];
    groups = json['groups'].cast<String>();
    customGroups = json['customGroups'].cast<String>();
    roles = json['roles'].cast<String>();
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['firstname'] = this.firstname;
    data['surname'] = this.surname;
    data['enabled'] = this.enabled;
    data['email'] = this.email;
    if (this.grants != null) {
      data['grants'] = this.grants!.toJson();
    }
    data['deleted'] = this.deleted;
    data['groups'] = this.groups;
    data['customGroups'] = this.customGroups;
    data['roles'] = this.roles;
    data['grade'] = this.grade;
    return data;
  }
}

class Grants {

Grants.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  return data;
}
}

class MaxFileSize {
  int? audio;
  int? excel;
  int? image;
  int? pdf;
  int? powerpoint;
  int? video;
  int? word;

  MaxFileSize({this.audio, this.excel, this.image, this.pdf, this.powerpoint, this.video, this.word});

  MaxFileSize.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
    excel = json['excel'];
    image = json['image'];
    pdf = json['pdf'];
    powerpoint = json['powerpoint'];
    video = json['video'];
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio'] = this.audio;
    data['excel'] = this.excel;
    data['image'] = this.image;
    data['pdf'] = this.pdf;
    data['powerpoint'] = this.powerpoint;
    data['video'] = this.video;
    data['word'] = this.word;
    return data;
  }
}

class DeviceFeatures {
  int? maxQuota;
  int? quotaUsed;
  int? xkv;
  String? storeUrl;

  DeviceFeatures({this.maxQuota, this.quotaUsed, this.xkv, this.storeUrl});

  DeviceFeatures.fromJson(Map<String, dynamic> json) {
    maxQuota = json['maxQuota'];
    quotaUsed = json['quotaUsed'];
    xkv = json['xkv'];
    storeUrl = json['storeUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxQuota'] = this.maxQuota;
    data['quotaUsed'] = this.quotaUsed;
    data['xkv'] = this.xkv;
    data['storeUrl'] = this.storeUrl;
    return data;
  }
}