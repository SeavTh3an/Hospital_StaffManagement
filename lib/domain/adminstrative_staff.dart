import 'staff.dart';
import 'payroll.dart';

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
  }) : super.admin(name, dob, gender, salary, hireDate, payroll, role);

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
        'ID': id,
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
  void displayInfo() {
    final bonus = calculateBonus();
    final workingYears = getWorkingYears();
    final netSalary = payroll.calculateNetSalary(salary, bonus: bonus); 
    print('ID: $id');
    print('Name: $name');
    print('Gender: ${gender.toString().split('.').last}');
    print('DOB: ${dob.toIso8601String()}');
    print('Position: Administrative');
    print('Role: ${role.toString().split('.').last}');
    print('Working Years: $workingYears');
    print('Bonus: \$${bonus.toStringAsFixed(2)}');
    print('Gross Salary: \$${salary.toStringAsFixed(2)}');
    print('Net Salary (after tax & deductions): \$${netSalary.toStringAsFixed(2)}'); 
    print('Hire Date: ${hireDate.toIso8601String()}');
  }

  @override
  double calculateBonus() {
    switch (role) {
      case Role.Accountant:
        return salary * 0.5;
      case Role.Receptionist:
        return salary * 0.3;
      default:
        return salary * 0.05;
    }
  }

  @override
  void updateInfo(String newName) {
    name = newName;
  }

  @override
  bool isOnProbation() {
    return DateTime.now().difference(hireDate).inDays < 60;
  }

  @override
  int getWorkingYears() {
    return DateTime.now().year - hireDate.year;
  }
}
