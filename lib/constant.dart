import 'package:schedule_tracker/class/company.dart';

final List<Company> companies = List.generate(
  3,
  (index) => Company(name: "Company $index", pay: index * 5.0, roundupIndex: 0),
);
