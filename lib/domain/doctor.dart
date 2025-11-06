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
        'ID': id,
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
  void displayInfo() {
    final bonus = calculateBonus();
    final workingYears = getWorkingYears();
    final netSalary = payroll.calculateNetSalary(salary, bonus: bonus);
    print('ID: $id');
    print('Name: $name');
    print('Gender: ${gender.toString().split('.').last}');
    print('DOB: ${dob.toIso8601String()}');
    print('Position: Doctor');
    print('Specialization: $specialization');
    print('Experience: $experienceYears years');
    print('Bonus: \$${bonus.toStringAsFixed(2)}');
    print('Gross Salary: \$${salary.toStringAsFixed(2)}');
    print('Net Salary (after tax & deductions): \$${netSalary.toStringAsFixed(2)}'); 
    print('Hire Date: ${hireDate.toIso8601String()}');
    print('Working Years: $workingYears');
  }

@override
void updateInfo(String field, dynamic newValue) {
  switch (field.toLowerCase()) {
    case 'name':
      name = newValue;
      break;
    case 'specialization':
      specialization = newValue;
      break;
    case 'experience':
      experienceYears = int.tryParse(newValue.toString()) ?? experienceYears;
      break;
    default:
      print('Invalid field for Doctor. You can update name, specialization, or experience.');
  }
}

  @override
  bool isOnProbation() {
    return DateTime.now().difference(hireDate).inDays < 180;
  }

  @override
  int getWorkingYears() {
    return DateTime.now().year - hireDate.year;
  }

  @override
  double calculateBonus() {
    if (experienceYears >= 10) return salary * 0.20;
    if (experienceYears >= 5) return salary * 0.15;
    return salary * 0.10;
  }
}