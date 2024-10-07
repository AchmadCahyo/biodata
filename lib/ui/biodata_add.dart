import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:biodata/models/datamodel.dart';
import 'package:biodata/models/api.dart';
// import 'package:biodata/ui/biodata_form.dart';
import 'package:intl/intl.dart';

class BiodataAdd extends StatefulWidget {
  const BiodataAdd({super.key});

  @override
  State<StatefulWidget> createState() => BiodataAddState();
}

class BiodataAddState extends State<BiodataAdd> {
  final formkey = GlobalKey<FormState>();
  TextEditingController namaController = new TextEditingController();
  TextEditingController tplahirController = new TextEditingController();
  TextEditingController tglahirController = new TextEditingController();
  TextEditingController agamaController = new TextEditingController();
  TextEditingController kelaminController = new TextEditingController();
  TextEditingController alamatController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  String _kelamin = "";
  final List<String> _status = ['Laki-laki', 'Perempuan'];
  final List<String> items = [
    "",
    "Islam",
    "Katholik",
    "Protestan",
    "Hindu",
    "Budha",
    "Konghucu",
    "Kepercayaan"
  ];
  String? selectedValue;

  Future createSw() async {
    return await http.post(
      Uri.parse(BaseUrl.tambah),
      body: {
        "nama": namaController.text,
        "tempat_lahir": tplahirController.text,
        "tanggal_lahir": tglahirController.text,
        "agama": selectedValue ?? 'Tidak Dipilih',
        "kelamin": kelaminController.text,
        "alamat": alamatController.text,
        "email": emailController.text,
      },
    );
  }

  void _onConfirm(context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if(data['success']) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Data"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _tbNama(),
            const SizedBox(height: 10),
            _tbTempat(),
            const SizedBox(height: 10),
            _tbTanggal(),
            const SizedBox(height: 10),
            _tbAgama(),
            const SizedBox(height: 10),
            _tbKelamin(),
            const SizedBox(height: 10),
            _tbAlamat(),
            const SizedBox(height: 10),
            _tbEmail(),
            const SizedBox(height: 10),
            _save(),
          ],
        ),
      ),
    );
  }

  _tbNama() {
    return TextFormField(
      controller: namaController, // Hubungkan controller
      decoration: InputDecoration(
        labelText: 'Nama',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkkan Nama Anda...';
        }
        return null;
      },
    );
  }

  _tbTempat() {
    return TextFormField(
      controller: tplahirController, // Hubungkan controller
      decoration: InputDecoration(
        labelText: 'Tempat Lahir',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkkan Kota Kelahiran Anda...';
        }
        return null;
      },
    );
  }

  _tbTanggal() {
    return TextFormField(
      readOnly: true,
      controller: tglahirController,
      decoration: InputDecoration(
        labelText: 'Tanggal Lahir',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 150),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          tglahirController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Silahkan Pilih Tanggal Lahir Anda...';
        }
        return null;
      },
    );
  }

  _tbAlamat() {
    return TextFormField(
      controller: alamatController, // Hubungkan controller
      decoration: InputDecoration(
        labelText: 'Alamat',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      maxLines: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkkan Alamat Anda...';
        }
        return null;
      },
    );
  }

  _tbEmail() {
    return TextFormField(
      controller: emailController, // Hubungkan controller
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || !value.contains('@')) {
          return 'Masukkkan Email yang Valid...';
        }
        return null;
      },
    );
  }

  _tbKelamin() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.wc),
              SizedBox(width: 10.0),
              Text(
                "Student Gender",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          RadioGroup<String>.builder(
            groupValue: _kelamin,
            onChanged: (value) => setState(() {
              _kelamin = value ?? '';
            }),
            items: _status,
            itemBuilder: (item) => RadioButtonBuilder(
              item,
              textPosition: RadioButtonTextPosition.right,
            ),
            activeColor: Colors.purple,
            fillColor: Colors.purple,
          ),
        ],
      ),
    );
  }

  _tbAgama() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Student Religion',
          prefixIcon: Icon(Icons.mosque), // Ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        isExpanded: true, // Membuat dropdown sesuai lebar container
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14),
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
        },
      ),
    );
  }

  _save() {
    return ElevatedButton(
      onPressed: () {
        _onConfirm(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple, // Warna teks
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Membuat sudut tombol melengkung
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 30.0), // Padding di dalam tombol
        elevation: 5.0, // Efek shadow di bawah tombol
        shadowColor: Colors.grey.withOpacity(0.5), // Warna shadow
      ),
      child: const Text(
        'Submit',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
