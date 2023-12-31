class Payment {
  final int id;
  final String emailUser;
  final String paymentDate;
  final String expiredDate;
  final String categoryPremium;
  final String price;

  Payment({
    required this.id,
    required this.emailUser,
    required this.paymentDate,
    required this.expiredDate,
    required this.categoryPremium,
    required this.price,
  });

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'],
      emailUser: map['emailUser'],
      paymentDate: map['paymentDate'],
      expiredDate: map['expiredDate'],
      categoryPremium: map['categoryPremium'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emailUser': emailUser,
      'paymentDate': paymentDate,
      'expiredDate': expiredDate,
      'categoryPremium': categoryPremium,
      'price': price,
    };
  }
}
