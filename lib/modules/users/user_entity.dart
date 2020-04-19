import 'dart:convert';

List<UserEntity> usersEntityFromJson(String str) => List<UserEntity>.from(json.decode(str).map((x) => UserEntity.fromJson(x)));

String usersEntityToJson(List<UserEntity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserEntity {
    int userId;
    int id;
    String title;
    String body;

    UserEntity({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    UserEntity copyWith({
        int userId,
        int id,
        String title,
        String body,
    }) => 
        UserEntity(
            userId: userId ?? this.userId,
            id: id ?? this.id,
            title: title ?? this.title,
            body: body ?? this.body,
        );

    factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
