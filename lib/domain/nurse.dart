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

  factory Nurse.fromJson(Map<String, dynamic> json) {
    return Nurse(
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      gender: Gender.values
          .firstWhere((g) => g.toString() == 'Gender.${json['gender']}'),
      salary: json['salary'],
      hireDate: DateTime.parse(json['hireDate']),
      shift: json['shift'] ?? '',
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
        'position': 'Nurse',
        'hireDate': hireDate.toIso8601String(),
        'shift': shift,
        'payroll': payroll.toJson(),
      };
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
  void displayInfo() {
    throw UnimplementedError();
  }
}
