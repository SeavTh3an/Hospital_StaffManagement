import 'staff.dart';
import 'payroll.dart';
class Nurse extends Staff {
  String shift;

  Nurse({
    required String name,
    required DateTime dob,
    required Gender gender,
    required double salary,
    required DateTime hireDate,
    required this.shift,
    required Payroll payroll,
  }) : super(name, dob, gender, salary, Position.Nurse, hireDate, payroll);

  bool isNightShift() {
    
    throw UnimplementedError();
  }

  @override
  double calculateBonus() {
    throw UnimplementedError();
  }

  @override
  double calculateSalaryWithOvertime(double hours) {
    throw UnimplementedError();
  }

  @override
  void updateInfo(String name) {
    throw UnimplementedError();
  }

  @override
  bool isOnProbation() {
    throw UnimplementedError();
  }

  @override
  int getWorkingYears() {
    throw UnimplementedError();
  }

  @override
  double getMonthlyPayroll() {
    throw UnimplementedError();
  }

  @override
  void displayInfo() {
    throw UnimplementedError();
  }

  
}
