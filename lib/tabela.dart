import 'dart:async';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tabela extends StatefulWidget {
  const Tabela({super.key});

  @override
  State<Tabela> createState() => _TabelaState();
}

class _TabelaState extends State<Tabela> {
  List<List<dynamic>> dadosTabela = [];
  List<List<dynamic>> dadosFiltrados = [];
  final buscaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  Future<void> _loadCSV() async {
    final rawData = await rootBundle.loadString('assets/mycsv.csv');

    List<List<dynamic>> listData =
        const CsvToListConverter(fieldDelimiter: ";", eol: "\n")
            .convert(rawData);

    setState(() {
      dadosTabela = listData;
      dadosFiltrados = listData;
    });
  }

  void _filtrarDados(String query) {
    setState(() {
      dadosFiltrados = dadosTabela
          .where((row) =>
              row[0].toString().toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    });
  }

  Color _getRowColor(int index) {
    return index % 2 == 0 ? Colors.blue.shade200 : Colors.blue.shade50;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Expanded(
          child: Card(
            color: Colors.black,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'NOME DO PRODUTO',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox.shrink(),
                Text(
                  'PREÇO',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        controller: buscaEC,
                        onChanged: (query) {
                          _filtrarDados(query);
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          labelText: 'Digite o nome do produto',
                          suffixIcon: const Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: dadosFiltrados.length,
                          itemBuilder: (_, index) {
                            return Expanded(
                              child: Card(
                                margin: const EdgeInsets.all(2),
                                color: _getRowColor(index),
                                child: ListTile(
                                  leading: Text(
                                    dadosFiltrados[index][0].toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),

                                  // leading: TextField(
                                  //   decoration: InputDecoration(
                                  //     labelText:
                                  //         dadosFiltrados[index][0].toString(),
                                  //   ),
                                  // style: const TextStyle(
                                  //     fontSize: 12,
                                  //     fontWeight: FontWeight.bold),

                                  trailing: Text(
                                    dadosFiltrados[index][1].toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
