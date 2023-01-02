class Order {
  Order({
    this.id,
    this.idUser,
    this.price,
    this.date,
    this.status,
  });

  String? id;
  String? price;
  String? idUser;
  String? date;
  String? status;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        idUser: json["idUser"],
        price: json["price"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "price": price,
        "date": date,
        "status": status,
      };
  factory Order.copyWith(Order? order) => Order(
        id: order?.id,
        idUser: order?.idUser,
        price: order?.price,
        date: order?.date,
        status: order?.status,
      );
}
