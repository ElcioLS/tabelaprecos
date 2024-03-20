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
    final rawData = await rootBundle.loadString('assets/mycsv.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    setState(() {
      _data = listData;
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
                // _data[0].toString(),
                'Tabela de Preços',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _loadCSV(
            
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
                // title: Text(
                //   _data[index][1].toString(),
                //   style: const TextStyle(
                //       fontSize: 18, fontWeight: FontWeight.bold),
                // ),
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
