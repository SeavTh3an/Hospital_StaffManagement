
import 'package:my_first_project/domain/payroll.dart';

import 'staff.dart';

class AdministrativeStaff extends Staff {
  Role role;

  AdministrativeStaff({
    required String name,
    required DateTime dob,
    required Gender gender,
    required double salary,
    required DateTime hireDate,
    required this.role,
    required Payroll payroll, 
  }) : super.admin(
          name,
          dob,
          gender,
          salary,
          hireDate,
          payroll, 
          role,
        );

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
