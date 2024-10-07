class DataModel {
  final int id;
  final String nama, tempat_lahir, tanggal_lahir, agama, kelamin, alamat, email;
  DataModel(
      {required this.id,
      required this.nama,
      required this.tempat_lahir,
      required this.tanggal_lahir,
      required this.agama,
      required this.kelamin,
      required this.alamat,
      required this.email});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        id: json['id'],
        nama: json['nama'],
        tempat_lahir: json['tempat_lahir'],
        tanggal_lahir: json['tanggal_lahir'],
        agama: json['agama'],
        kelamin: json['kelamin'],
        alamat: json['alamat'],
        email: json['email']);
  }
  Map<String, dynamic> toJson() => {
        'nama': nama,
        'tempat_lahir': tempat_lahir,
        'tanggal_lahir': tanggal_lahir,
        'agama': agama,
        'kelamin': kelamin,
        'alamat': alamat,
        'email': email,
      };
}
