import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/datamodel.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/ui/biodata_form.dart';

//NOTE: Buat file tambah data terpisah

class BiodataEdit extends StatefulWidget {
  final DataModel sw;

  const BiodataEdit({super.key, required this.sw});

  @override
  EditState createState() => EditState();
}

class EditState extends State<BiodataEdit> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController namaController,
      tpController,
      tgController,
      alamatController,
      emailController,
      kelaminController,
      agamaController;

  Future editSw() async {
    return await http.post(
      Uri.parse(BaseUrl.edit),
      body: {
        "id": widget.sw.id.toString(),
        "nama": namaController.text,
        "tempat_lahir": tpController.text,
        "tanggal_lahir": tgController.text,
        "agama": agamaController.text,
        "kelamin": kelaminController.text,
        "alamat": alamatController.text,
        "email": emailController.text,
      },
    );
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Data Berhasil Dirubah",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16);
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    namaController = TextEditingController(text: widget.sw.nama);
    tpController = TextEditingController(text: widget.sw.tempat_lahir);
    tgController = TextEditingController(text: widget.sw.tanggal_lahir);
    agamaController = TextEditingController(text: widget.sw.agama);
    kelaminController = TextEditingController(text: widget.sw.kelamin);
    alamatController = TextEditingController(text: widget.sw.alamat);
    emailController = TextEditingController(text: widget.sw.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Data"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          child: const Text("Update"),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              _onConfirm(context);
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(28.0), // Pastikan padding langsung di sini
        child: Center( // Form di sini adalah form utama
          child: BiodataForm(
            formkey: formKey, // Operkan key form
            namaController: namaController,
            tplahirController: tpController,
            tglahirController: tgController,
            agamaController: agamaController,
            kelaminController: kelaminController,
            alamatController: alamatController,
            emailController: emailController,
          ),
        ),
      ),
    );
  }
}
