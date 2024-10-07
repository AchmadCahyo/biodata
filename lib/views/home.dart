import 'dart:convert';
import 'dart:async';
import 'package:biodata/ui/biodata_add.dart';
import 'package:flutter/material.dart';
import 'package:biodata/models/datamodel.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/ui/biodata_detail.dart';
import 'package:http/http.dart' as http;
// import 'package:biodata/ui/biodata_form.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // Inisialisasi GlobalKey untuk form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Inisialisasi controller untuk form input
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tplahirController = TextEditingController();
  final TextEditingController tglahirController = TextEditingController();
  final TextEditingController agamaController = TextEditingController();
  final TextEditingController kelaminController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  late Future<List<DataModel>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<DataModel>> getSwList() async {
    try {
      final response = await http.get(Uri.parse(BaseUrl.data));
      print(response.statusCode); // Cek kode status HTTP
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        print(items); // Cek data yang diterima
        return items
            .map<DataModel>((json) => DataModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<DataModel>>(
              future: sw,
              builder: (BuildContext context,
                  AsyncSnapshot<List<DataModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print('Error: ${snapshot.error}'); // Tambahkan log error
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data found'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data![index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        trailing: const Icon(Icons.view_list),
                        title: Text(
                          data.nama,
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle:
                            Text("${data.tempat_lahir}, ${data.tanggal_lahir}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BiodataDetail(sw: data),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.green,
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          print("Floating Action Button pressed");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BiodataAdd()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
