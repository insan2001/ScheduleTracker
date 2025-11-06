import 'package:flutter/material.dart';
import 'package:schedule_tracker/constant.dart';
import 'package:schedule_tracker/screen/company.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    for (var company in companies) {
      company.onTick = () {
        if (mounted) {
          setState(() {});
        }
      };
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Work places"), centerTitle: true),
        body: Center(
          child: ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(companies[index].name),
                subtitle: Text(
                  companies[index].isClockedIn
                      ? companies[index].formattedElapsed
                      : "Clock in to work",
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompanyScreen(index: index),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    companies[index].toggleClock();
                  },
                  icon: Icon(
                    companies[index].isClockedIn
                        ? Icons.stop
                        : Icons.play_arrow,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
