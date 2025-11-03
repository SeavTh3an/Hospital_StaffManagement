
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
    factory AdministrativeStaff.fromJson(Map<String, dynamic> json) {
    return AdministrativeStaff(
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      gender: Gender.values.firstWhere((g) => g.toString() == 'Gender.${json['gender']}'),
      salary: json['salary'],
      hireDate: DateTime.parse(json['hireDate']),
      role: Role.values.firstWhere((r) => r.toString() == 'Role.${json['role']}'),
      payroll: Payroll.fromJson(json['payroll']),
    );
  }
    @override
    Map<String, dynamic> toJson() => {
        'ID': ID,
        'name': name,
        'dob': dob.toIso8601String(),
        'gender': gender.toString().split('.').last,
        'salary': salary,
        'position': 'Administrative',
        'hireDate': hireDate.toIso8601String(),
        'role': role.toString().split('.').last,
        'payroll': payroll.toJson(),
      };

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
  void displayInfo() {
    throw UnimplementedError();
  }
}
