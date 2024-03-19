import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tabela extends StatefulWidget {
  const Tabela({super.key});

  @override
  State<Tabela> createState() => _TabelaState();
}

class _TabelaState extends State<Tabela> {
  List<List<dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString('assets/tabela.csv');
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
        title: const Center(
          child: Card(
              margin: EdgeInsets.all(2),
              child: Text(
                'Produto | Preço | Saldo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadCSV,
        child: const Icon(Icons.search),
      ),
      body: _data == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (_, index) {
                return Card(
                    margin: const EdgeInsets.all(3),
                    color: index == 0 ? Colors.red[400] : Colors.white12,
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
