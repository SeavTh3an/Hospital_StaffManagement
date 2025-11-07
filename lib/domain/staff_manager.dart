import 'staff.dart';
import 'nurse.dart';
import '../data/staff_repository.dart';

class StaffManager {
  List<Staff> staffList = [];
  final StaffRepository repository;

  StaffManager({required this.repository}) {
    staffList = repository.loadAllStaff();
  }

  void addStaff(Staff staff) {
    staffList.add(staff);
    repository.saveAllStaff(staffList); 
  }

  bool removeStaff(String id) {
    final staffToRemove = findStaffById(id);
    if (staffToRemove != null) {
      staffList.remove(staffToRemove);
      repository.saveAllStaff(staffList); 
      return true;
    }
    return false;
  }

  Staff? findStaffById(String id) {
    for (var s in staffList) {
      if (s.id == id) return s;
    }
    return null;
  }

  bool updateSalary(String id, double newSalary) {
    final staff = findStaffById(id);
    if (staff != null) {
      staff.salary = newSalary;
      repository.saveAllStaff(staffList);
      return true;
    }
    return false;
  }

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

  List<Staff> getStaffByPosition(Position pos) {
    return staffList.where((s) => s.position == pos).toList();
  }
  
  double getTotalMonthlyPayroll() {
    double total = 0;
    for (var s in staffList) {
      total += s.payroll.calculateNetSalary(s.salary); 
    }
    return total;
  }

  void displayMonthlyPayroll() {
    print('=================== Monthly Payroll Report ===================');
    print('${'ID'.padRight(10)}${'Name'.padRight(15)}${'Position'.padRight(20)}${'Salary'.padRight(15)}${'Net Pay'.padRight(10)}');
    print('--------------------------------------------------------------------');

    for (var s in staffList) {
      final pos = s.position.toString().split('.').last;
      final net = s.payroll.calculateNetSalary(s.salary); 

      print('${s.id.padRight(10)}${s.name.padRight(15)}${pos.padRight(20)}'
            '${s.salary.toStringAsFixed(2).padRight(15)}'
            '${net.toStringAsFixed(2).padRight(10)}');
    }
    print('--------------------------------------------------------------------');
    
    final total = getTotalMonthlyPayroll();
    print('Total Monthly Payroll: \$${total.toStringAsFixed(2)}');
  }

  List<Nurse> getDutyToday(String shift) {
    return staffList.where((s) => s is Nurse && s.shift == shift).cast<Nurse>().toList();
  }

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
      final hireDateStr = s.hireDate.toString().split(' ')[0]; 

      print('${s.id.padRight(10)}'
            '${s.name.padRight(15)}'
            '${genderStr.padRight(15)}'
            '${positionStr.padRight(20)}'
            '${hireDateStr.padRight(15)}');
    }
  }

  void saveAllStaff() {
    repository.saveAllStaff(staffList);
  }
}