import 'dart:convert';


class AuthModel {
  final String accessToken;
  AuthModel({
    required this.accessToken,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'access_token': accessToken});
  
    return result;
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: (map['access_token'] ?? '')as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) => AuthModel.fromMap(json.decode(source)as Map<String,dynamic>);
}
