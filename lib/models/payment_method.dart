class PaymentMethod {
  final int id;
  final String name;
  final String image;

  PaymentMethod({required this.id, required this.name, required this.image});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
        id: json["id"], name: json["name"], image: json["image"]);
  }
}
