import 'dart:io';
import 'dart:convert';
import '../domain/payroll.dart';

class PayrollRepository {
  final String filePath;

  PayrollRepository(this.filePath);

  Map<String, Payroll> loadPayrolls() {
    final file = File(filePath);
    if (!file.existsSync()) throw Exception('Payroll data not found!');
    final jsonData = jsonDecode(file.readAsStringSync());

    // Convert JSON map to Payroll objects
    return {
      'Doctor': Payroll.fromJson(jsonData['Doctor']),
      'Nurse': Payroll.fromJson(jsonData['Nurse']),
      'Administrative': Payroll.fromJson(jsonData['Administrative']),
    };
  }
}
