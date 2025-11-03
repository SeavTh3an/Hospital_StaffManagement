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

    factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      dob: DateTime.parse(json['dob']),
      gender: Gender.values.firstWhere((g) => g.toString() == 'Gender.${json['gender']}'),
      salary: json['salary'],
      hireDate: DateTime.parse(json['hireDate']),
      specialization: json['specialization'] ?? '',
      experienceYears: json['experienceYears'] ?? 0,
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
        'position': 'Doctor',
        'hireDate': hireDate.toIso8601String(),
        'specialization': specialization,
        'experienceYears': experienceYears,
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
