import 'staff.dart';

class AdminStaff extends Staff {
  final Role role;

  AdminStaff(
    String name,
    DateTime dob,
    String gender,
    double salary,
    DateTime hireDate,
    this.role,
  ) : super.admin(name, dob, gender, salary, hireDate, role);

  @override
  double calculateBonus() {
    return salary * 0.15;
  }
}
