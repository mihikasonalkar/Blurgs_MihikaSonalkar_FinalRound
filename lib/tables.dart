import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class TablePage extends StatefulWidget {
  String index;
  TablePage({Key? key, required this.index}) : super(key: key);

  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  List<List<dynamic>> _data = [];

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/000${widget.index}.csv");
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
        title: const Text("App Test"),
      ),
      // Display the contents from the CSV file
      body: SingleChildScrollView(
        child: Table(
          columnWidths: {
            0: FixedColumnWidth(100.0),
            1: FixedColumnWidth(200.0),
          },
          border: TableBorder.all(width: 1.0),
          children: _data.map((item) {
            return TableRow(
                children: item.map((row) {
                  return Container(
                    color:
                    row.toString().contains("NA") ? Colors.red : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        row.toString(),
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                  );
                }).toList());
          }).toList(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), onPressed: _loadCSV),
    );
  }
}



