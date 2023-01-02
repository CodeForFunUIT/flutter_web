class OrderDetail {
  OrderDetail({
    this.id,
    this.idUser,
    this.idProduct,
    this.number,
    this.name,
    this.price,
    this.date,
    this.status,
  });

  String? id;
  String? name;
  String? price;
  String? idUser;
  String? idProduct;
  String? number;
  String? date;
  String? status;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        idUser: json["idUser"],
        idProduct: json["idProduct"],
        number: json["number"],
        name: json["name"],
        price: json["price"],
        date: json["date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "idProduct": idProduct,
        "number": number,
        "name": name,
        "price": price,
        "date": date,
        "status": status,
      };
  factory OrderDetail.copyWith(OrderDetail? orderDetail) => OrderDetail(
        id: orderDetail?.id,
        idUser: orderDetail?.idUser,
        idProduct: orderDetail?.idProduct,
        number: orderDetail?.number,
        name: orderDetail?.name,
        price: orderDetail?.price,
        date: orderDetail?.date,
        status: orderDetail?.status,
      );
}
