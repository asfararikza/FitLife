class Account {
  final String email;
  final String username;
  final String password;
  final int isPremium;

  Account({
    required this.email,
    required this.username,
    required this.password,
    required this.isPremium,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'isPremium': isPremium,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      email: map['email'],
      username: map['username'],
      password: map['password'],
      isPremium: map['isPremium'],
    );
  }
}
