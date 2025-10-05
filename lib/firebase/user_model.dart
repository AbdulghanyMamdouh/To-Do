class MyUser {
  String? name;
  String? uId;
  String? email;
  static const String collectionName = 'My User';
  MyUser({required this.email, required this.name, required this.uId});
  MyUser.fromFirestore(Map<String, dynamic> data)
      : this(
          name: data['name'] as String?,
          uId: data['uId'] as String?,
          email: data['email'] as String?,
        );
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'uId': uId,
      'email': email,
    };
  }
}
