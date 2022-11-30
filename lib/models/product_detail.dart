class ProductDetail {
  String? id;
  String? soNhan;
  String? soLuong;
  String? xungNhipCoBan;
  String? xungNhipToiDa;
  String? theHe;
  String? doHoa;
  String? tienTrinh;
  String? ram;
  String? chuanRam;
  String? bus;
  String? ramDetai;
  String? oCung;
  String? manHinh;
  String? trongLuong;
  String? idProduct;
  String? cpu;

  ProductDetail({
    this.id,
    this.soNhan,
    this.soLuong,
    this.xungNhipCoBan,
    this.xungNhipToiDa,
    this.theHe,
    this.doHoa,
    this.tienTrinh,
    this.ram,
    this.chuanRam,
    this.bus,
    this.ramDetai,
    this.oCung,
    this.manHinh,
    this.trongLuong,
    this.idProduct,
    this.cpu,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'] ?? '0',
      soNhan: json['soNhan'] ?? '0',
      soLuong: json['soLuong'] ?? '0',
      xungNhipCoBan: json['xungNhipCoBan'] ?? '',
      xungNhipToiDa: json['xungNhipToiDa'] ?? '',
      theHe: json['theHe'] ?? '',
      doHoa: json['doHoa'] ?? '',
      tienTrinh: json['tienTrinh'] ?? '',
      ram: json['ram'] ?? '',
      chuanRam: json['chuanRam'] ?? '',
      bus: json['bus'] ?? '',
      ramDetai: json['ramDetail'] ?? '',
      oCung: json['oCung'] ?? '',
      manHinh: json['manHinh'] ?? '',
      trongLuong: json['trongLuong'] ?? '',
      idProduct: json['idProduct'] ?? '0',
      cpu: json['cpu'] ?? '',
    );
  }

  Map<String, dynamic> laptopToJson() => {
        "ramDetail": ramDetai,
        "oCung": oCung,
        "manHinh": manHinh,
        "trongLuong": trongLuong,
        "cpu": cpu,
      };
  Map<String, dynamic> cpuToJson() => {
        "tienTrinh": tienTrinh,
        "soNhan": soNhan,
        "soLuong": soLuong,
        "xungNhipCoBan": xungNhipCoBan,
        "xungNhipToiDa": xungNhipToiDa,
        "theHe": theHe,
        "doHoa": doHoa,
      };
  Map<String, dynamic> ramToJson() => {
        "ram": ram,
        "chuanRam": chuanRam,
        "bus": bus,
      };
}
