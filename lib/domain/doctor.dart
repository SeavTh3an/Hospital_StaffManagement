import 'staff.dart';
import 'payroll.dart';
class Doctor extends Staff {
  String specialization;
  int experienceYears;

  Doctor({
    required String name,
    required DateTime dob,
    required Gender gender,
    required double salary,
    required DateTime hireDate,
    required this.specialization,
    required this.experienceYears,
    required Payroll payroll,
  }) : super(name, dob, gender, salary, Position.Doctor, hireDate, payroll);

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
