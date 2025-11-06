import 'package:flutter/material.dart';
import 'package:schedule_tracker/class/company.dart';
import 'package:schedule_tracker/constant.dart';

class CompanyScreen extends StatefulWidget {
  final int index;
  const CompanyScreen({super.key, required this.index});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  final TextEditingController _controller = TextEditingController();
  late final Company company;
  bool isChanged = false;

  Future<dynamic> popup(final String title, final Function function) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit pay'),
        content: TextField(
          controller: _controller,
          keyboardType: TextInputType.name,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close popup
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              function();
              Navigator.pop(context); // Close popup
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    company = companies[widget.index];
    company.onTick = () {
      setState(() {});
    };
    _controller.text = company.pay.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => popup("Edit title", () {
              if (_controller.text != "")
                companies[widget.index].name = _controller.text;
            }),
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Pay"),
              trailing: IconButton(
                onPressed: () => popup("Edit pay", () {
                  if (_controller.text == "") return;
                  double pay;
                  try {
                    pay = double.parse(_controller.text);
                  } catch (e) {
                    return;
                  }
                  companies[widget.index].pay = pay;
                }),
                icon: Icon(Icons.edit),
              ),
            ),
          ],
        ),
      ),
      // implement save
      floatingActionButton: isChanged
          ? TextButton(onPressed: null, child: Text("Save"))
          : null,
    );
  }
}
