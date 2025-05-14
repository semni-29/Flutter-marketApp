/*
class CraftyUser {
  final String email;
  final String password;
  final String type;
  final String uid;

  CraftyUser({
    required this.email,
    required this.password,
    required this.type,
    required this.uid,
  });
}
*/


class CraftyUser {
  final String email;
  final String password;
  late String type;
  late String uid;

  CraftyUser({required this.email, required this.password});
}
