import 'dart:convert';

import 'package:flutter_web_electronic_components/models/address.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  static AddressController instance = Get.find();

  List<Province> _provinces = [];
  List<Province> get provinces => _provinces;
  set provinces(List<Province> data) {
    _provinces.clear();
    _provinces = [...data];
    update();
  }

  List<District> _districts = [];
  List<District> get districts => _districts;
  set districts(List<District> data) {
    _districts.clear();
    _districts = [...data];
    update();
  }

  List<Commune> _communes = [];
  List<Commune> get communes => _communes;
  set communes(List<Commune> data) {
    _communes.clear();
    _communes = [...data];
    update();
  }

  static const String baseUrl =
      'https://sheltered-anchorage-60344.herokuapp.com/';

  Future<void> getProvince() async {
    http.Response res = await http.get(Uri.parse('$baseUrl/province'));

    if (res.statusCode == 200) {
      _provinces = (jsonDecode(res.body) as List)
          .map((e) => Province(idProvince: e['idProvince'], name: e['name']))
          .toList();
    }
  }

  Future<void> getDistrict(String idProvince) async {
    http.Response res =
        await http.get(Uri.parse('$baseUrl/district/?idProvince=$idProvince'));
    if (res.statusCode == 200) {
      _districts = (jsonDecode(res.body) as List)
          .map(
            (e) => District(
              idProvince: e['idProvince'],
              name: e['name'],
              idDistrict: e['idDistrict'],
            ),
          )
          .toList();
    }
  }

  Future<void> getCommune(String idDistrict) async {
    http.Response res =
        await http.get(Uri.parse('$baseUrl/commune/?idDistrict=$idDistrict'));
    if (res.statusCode == 200) {
      _communes = (jsonDecode(res.body) as List)
          .map(
            (e) => Commune(
              idCommune: e['idCommune'],
              name: e['name'],
              idDistrict: e['idDistrict'],
            ),
          )
          .toList();
    }
  }
}
