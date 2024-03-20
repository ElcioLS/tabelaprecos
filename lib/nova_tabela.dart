import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NovaTabela extends StatefulWidget {
  const NovaTabela({Key? key}) : super(key: key);

  @override
  State<NovaTabela> createState() => _NovaTabelaState();
}

class _NovaTabelaState extends State<NovaTabela> {
  List<List<dynamic>> _data = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  void _loadCSV() async {
    final rawData = await rootBundle.loadString('assets/mycsv.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    setState(() {
      _data = listData;
    });
  }

  List<List<dynamic>> _searchData(String query) {
    return _data.where((row) {
      return row[0].toString().startsWith(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Card(
            margin: EdgeInsets.all(2),
            child: Text(
              'Tabela de Preços',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Buscar Produto'),
              content: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Iniciais do Produto',
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _data = _searchData(_searchController.text);
                    });
                  },
                  child: const Text('Buscar'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
      body: Center(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _data.length,
          itemBuilder: (_, index) {
            return Card(
              margin: const EdgeInsets.all(3),
              color: index == 0 ? Colors.red[400] : Colors.blue,
              child: ListTile(
                leading: Text(
                  _data[index][0].toString(),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                trailing: Text(
                  _data[index][1].toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
