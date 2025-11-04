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
        'ID': id,
        'name': name,
        'dob': dob.toIso8601String(),
        'gender': gender.toString().split('.').last,
        'salary': salary,
        'position': 'Nurse',
        'hireDate': hireDate.toIso8601String(),
        'shift': shift,
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
    print('Position: Nurse');
    print('Shift: $shift');
    print('Gross Salary: \$${salary.toStringAsFixed(2)}');
    print('Bonus: \$${bonus.toStringAsFixed(2)}');
    print('Net Salary (after tax & deductions): \$${netSalary.toStringAsFixed(2)}');
    print('Working Years: $workingYears');
    print('Hire Date: ${hireDate.toIso8601String()}');
  }

  @override
  void updateInfo(String newName) {
    name = newName;
  }

  @override
  bool isOnProbation() {
    return DateTime.now().difference(hireDate).inDays < 90;
  }

  @override
  int getWorkingYears() {
    return DateTime.now().year - hireDate.year;
  }

  bool isNightShift() {
    return shift.toLowerCase() == 'night';
  }

  @override
  double calculateBonus() {
    // Nurses get bonus only if night shift
    return isNightShift() ? salary * 0.10 : 0.0;
  }


}
