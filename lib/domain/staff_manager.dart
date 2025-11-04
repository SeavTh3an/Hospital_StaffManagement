import 'staff.dart';
import 'nurse.dart';
import '../data/staff_repository.dart';

class StaffManager {
  List<Staff> staffList = [];
  final StaffRepository repository;

  StaffManager({required this.repository}) {
    // Load all staff from JSON on initialization
    staffList = repository.loadAllStaff();
  }

  // Add a new staff and save to JSON
  void addStaff(Staff staff) {
    staffList.add(staff);
    repository.saveAllStaff(staffList); //Save everything
  }

  // Remove a staff by ID and update JSON
  bool removeStaff(String id) {
    final staffToRemove = findStaffById(id);
    if (staffToRemove != null) {
      staffList.remove(staffToRemove);
      repository.saveAllStaff(staffList); //Save everything
      return true;
    }
    return false;
  }

  // Find a staff by ID
  Staff? findStaffById(String id) {
    for (var s in staffList) {
      if (s.id == id) return s;
    }
    return null;
  }

  // Update salary of a staff by ID and save to JSON
  bool updateSalary(String id, double newSalary) {
    final staff = findStaffById(id);
    if (staff != null) {
      staff.salary = newSalary;
      repository.saveAllStaff(staffList); //Save everything
      return true;
    }
    return false;
  }

  // Display info of all staff
  void displayAllStaff() {
    if (staffList.isEmpty) {
      print('No staff found.');
      return;
    }
    print('${'ID'.padRight(10)}${'Name'.padRight(15)}${'Gender'.padRight(15)}${'Position'.padRight(15)}');
    print('-------------------------------------------------------------');

    for (var s in staffList) {
      final genderStr = s.gender.toString().split('.').last;
      final positionStr = s.position.toString().split('.').last;
      print('${s.id.padRight(10)}'
            '${s.name.padRight(15)}'
            '${genderStr.padRight(15)}'
            '${positionStr.padRight(15)}');
    }
  }

  // Get all staff of a certain position
  List<Staff> getStaffByPosition(Position pos) {
    return staffList.where((s) => s.position == pos).toList();
  }

  // Calculate total monthly payroll
  double getTotalMonthlyPayroll() {
    double total = 0;
    for (var s in staffList) {
      total += s.payroll.calculateNetSalary(s.salary); // Calculate net salary of all staff
    }
    return total;
  }

  void displayMonthlyPayroll() {
    print('=================== Monthly Payroll Report ===================');
    print('${'ID'.padRight(10)}${'Name'.padRight(15)}${'Position'.padRight(20)}${'Salary'.padRight(15)}${'Net Pay'.padRight(10)}');
    print('--------------------------------------------------------------------');

    for (var s in staffList) {
      final pos = s.position.toString().split('.').last;
      final net = s.payroll.calculateNetSalary(s.salary); // Calculate net salary of each individual staff

      print('${s.id.padRight(10)}${s.name.padRight(15)}${pos.padRight(20)}'
            '${s.salary.toStringAsFixed(2).padRight(15)}'
            '${net.toStringAsFixed(2).padRight(10)}');
    }
    print('--------------------------------------------------------------------');
    // here we call the helper
    final total = getTotalMonthlyPayroll();
    print('Total Monthly Payroll: \$${total.toStringAsFixed(2)}');
  }

  // Get nurses on duty for a specific shift
  List<Nurse> getDutyToday(String shift) {
    return staffList.where((s) => s is Nurse && s.shift == shift).cast<Nurse>().toList();
  }

  // Get staff who are still on probation
  List<Staff> getStaffOnProbation() {
    return staffList.where((s) => s.isOnProbation()).toList();
  }

  void displayStaffOnProbation() {
    final probationStaff = getStaffOnProbation();

    if (probationStaff.isEmpty) {
      print('No staff on probation.');
      return;
    }
    print('${'ID'.padRight(10)}'
          '${'Name'.padRight(15)}'
          '${'Gender'.padRight(15)}'
          '${'Position'.padRight(20)}'
          '${'Hire Date'.padRight(15)}');
    print('--------------------------------------------------------------------------');

    for (var s in probationStaff) {
      final genderStr = s.gender.toString().split('.').last;
      final positionStr = s.position.toString().split('.').last;
      final hireDateStr = s.hireDate.toString().split(' ')[0]; // Only date part

      print('${s.id.padRight(10)}'
            '${s.name.padRight(15)}'
            '${genderStr.padRight(15)}'
            '${positionStr.padRight(20)}'
            '${hireDateStr.padRight(15)}');
    }
  }

  // Save all staff to JSON files (for backup or after bulk changes)
  void saveAllStaff() {
    repository.saveAllStaff(staffList);
  }
}