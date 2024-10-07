import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/api.dart';
import 'package:biodata/models/datamodel.dart';
import 'package:biodata/ui/biodata_edit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class BiodataDetail extends StatefulWidget {
  final DataModel sw;
  const BiodataDetail({super.key, required this.sw});

  @override
  DetailState createState() => DetailState();
}

class DetailState extends State<BiodataDetail> {
  void deleteData(context) async {
    http.Response response = await http.post(
      Uri.parse(BaseUrl.hapus),
      body: {
        'id': widget.sw.id.toString(),
      },
    );
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Hapus Data Berhasil",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16);
  }

  void confirmDelete(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Yakin Ingin Hapus Data Ini?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Icon(Icons.cancel),
              ),
              ElevatedButton(
                onPressed: () => deleteData(context),
                child: const Icon(Icons.check_circle),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Data"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID : ${widget.sw.id}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Nama : ${widget.sw.nama}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Tempat Lahir : ${widget.sw.tempat_lahir}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Tanggal Lahir : ${widget.sw.tanggal_lahir}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Gender : ${widget.sw.kelamin}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Alamat : ${widget.sw.alamat}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Email : ${widget.sw.email}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => BiodataEdit(sw: widget.sw),
          ),
        ),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
