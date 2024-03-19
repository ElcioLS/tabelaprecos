import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString('assets/mycsv.csv');
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);

    setState(() {
      _data = _listData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produto | Preço'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadCSV,
        child: const Icon(Icons.search),
      ),
      body: _data == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (_, index) {
                return Card(
                    margin: EdgeInsets.all(3),
                    color: index == 0 ? Colors.amber : Colors.white12,
                    child: ListTile(
                      leading: Text(_data[index][0].toString()),
                      title: Text(_data[index][1]),
                      trailing: Text(_data[index][2].toString()),
                    ));
              },
            ),
    );
  }
}
