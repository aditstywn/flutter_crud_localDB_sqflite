import 'package:crud_local_db/pages/add_page.dart';
import 'package:crud_local_db/pages/edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/datasource/local_datasource.dart';
import '../data/models/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> datas = [];

  bool isLoading = false;

  Future<void> getDatas() async {
    setState(() {
      isLoading = true;
    });

    datas = await LocalDatasource().getDatas();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getDatas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Local DB'),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false, // Menyembunyikan back arrow
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : datas.isEmpty
              ? const Center(
                  child: Text('Data Kosong'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(6),
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Card(
                        child: ListTile(
                          title: Text(datas[index].title),
                          subtitle: Text(
                            datas[index].deskripsi,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditPage(
                                          data: datas[index],
                                        ),
                                      ));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await LocalDatasource()
                                      .deleteDataById(datas[index].id!);

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPage(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
