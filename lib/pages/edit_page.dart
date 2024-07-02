// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:crud_local_db/data/models/data.dart';

import '../data/datasource/local_datasource.dart';
import 'home_page.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Data data;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formkey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final deskripsiController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.data.title;
    deskripsiController.text = widget.data.deskripsi;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Data'),
        backgroundColor: Colors.grey,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title Wajib Diisi';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: deskripsiController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deskripsi Wajib Diisi';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  Data data = Data(
                    id: widget.data.id,
                    title: titleController.text,
                    deskripsi: deskripsiController.text,
                    createdAt: DateTime.now(),
                  );

                  LocalDatasource().updateDataById(data);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
