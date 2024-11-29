class VodafoneCash {
  int id;
  String number;

  VodafoneCash({required this.id, required this.number});

  factory VodafoneCash.fromJson(Map<String, dynamic> json) {
    return VodafoneCash(id: json["id"], number: json["number"]);
  }
}
