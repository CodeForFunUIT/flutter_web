// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.idProductType,
    this.name,
    this.price,
    this.trademark,
    this.stock,
    this.image,
  });

  String? id;
  String? idProductType;
  String? name;
  String? price;
  String? trademark;
  String? stock;
  String? image;

  factory Product.dev() => Product(
        id: '1',
        idProductType: '1',
        name: 'name',
        price: '10000000',
        trademark: 'Intel',
        stock: '10',
        image:
            'https://tmpfluttermysql.000webhostapp.com/image/ram/Ram%20Crucial%20DDR5%208GB%20Bus%204800MHz%20CL40%20CT8G48C40S5.jpg',
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] ?? '0',
        idProductType: json["idProductType"] ?? '0',
        name: json["name"] ?? '',
        price: json["price"] ?? '0',
        trademark: json["trademark"] ?? '',
        stock: json["stock"] ?? '0',
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idProductType": idProductType,
        "name": name,
        "price": price,
        "trademark": trademark,
        "stock": stock,
        "image": image,
      };
}
