class Province {
  int idProvince;
  String name;

  Province({required this.idProvince, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) =>
      Province(idProvince: json['idProvince'], name: json['name']);
}

class District {
  int idProvince;
  int idDistrict;
  String name;

  District({
    required this.idDistrict,
    required this.idProvince,
    required this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        idDistrict: json['idDistrict'],
        idProvince: json['idProvince'],
        name: json['name'],
      );
}

class Commune {
  int idDistrict;
  int idCommune;
  String name;

  Commune({
    required this.idDistrict,
    required this.idCommune,
    required this.name,
  });

  factory Commune.fromJson(Map<String, dynamic> json) => Commune(
        idDistrict: json['idDistrict'],
        idCommune: json['idCommune'],
        name: json['name'],
      );
}
