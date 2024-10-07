// import 'dart:convert';
// ignore_for_file: unused_field

import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
// import 'package:biodata/models/api.dart';
// import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class BiodataForm extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late TextEditingController namaController,
      tplahirController,
      tglahirController,
      agamaController,
      kelaminController,
      alamatController,
      emailController;

  BiodataForm(
      {super.key,
      required this.formkey,
      required this.namaController,
      required this.tplahirController,
      required this.tglahirController,
      required this.agamaController,
      required this.kelaminController,
      required this.alamatController,
      required this.emailController});

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<BiodataForm> {
  String _kelamin = "";
  final List<String> _status = ['', 'Laki-laki', 'Perempuan'];
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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formkey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            children: [
              tbNama(),
              const SizedBox(height: 16),
              tbTempat(),
              const SizedBox(height: 16),
              tbTanggal(),
              const SizedBox(height: 16),
              tbAgama(),
              const SizedBox(height: 16),
              tbKelamin(),
              const SizedBox(height: 16),
              tbAlamat(),
              const SizedBox(height: 16),
              tbEmail(),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
    );
  }

  Widget tbNama() {
    return TextFormField(
      controller: widget.namaController, // Hubungkan controller
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

  Widget tbTempat() {
    return TextFormField(
      controller: widget.tplahirController, // Hubungkan controller
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

  Widget tbTanggal() {
    return TextFormField(
      readOnly: true,
      controller: widget.tglahirController,
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
          widget.tglahirController.text =
              DateFormat('yyyy-MM-dd').format(pickedDate);
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

  Widget tbAlamat() {
    return TextFormField(
      controller: widget.alamatController, // Hubungkan controller
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

  Widget tbEmail() {
    return TextFormField(
      controller: widget.emailController, // Hubungkan controller
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

  Widget tbKelamin() {
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

  Widget tbAgama() {
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
}
