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

  /// Add a new staff and save to JSON
  void addStaff(Staff staff) {
    staffList.add(staff);
    repository.saveStaffByPosition(staff.position, getStaffByPosition(staff.position));
  }

  /// Remove a staff by ID and update JSON
  bool removeStaff(String id) {
    final staffToRemove = findStaffById(id);
    if (staffToRemove != null) {
      staffList.remove(staffToRemove);
      repository.saveStaffByPosition(staffToRemove.position, getStaffByPosition(staffToRemove.position));
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

  /// Update salary of a staff by ID and save to JSON
  bool updateSalary(String id, double newSalary) {
    final staff = findStaffById(id);
    if (staff != null) {
      staff.salary = newSalary;
      repository.saveStaffByPosition(staff.position, getStaffByPosition(staff.position));
      return true;
    }
    return false;
  }

  /// Display info of all staff
  void displayAllStaff() {
    if (staffList.isEmpty) {
      print('No staff found.');
      return;
    }

    for (var s in staffList) {
      s.displayInfo(); // Each staff class implements this
      print('-----------------------------');
    }
  }

  /// Get all staff of a certain position
  List<Staff> getStaffByPosition(Position pos) {
    return staffList.where((s) => s.position == pos).toList();
  }

  /// Calculate total monthly payroll
  double getTotalMonthlyPayroll() {
    double total = 0;
    for (var s in staffList) {
      total += s.payroll.calculateNetSalary(s.salary); // ✅ UPDATED: include payroll logic
    }
    return total;
  }

  /// Get staff who are still on probation
  List<Staff> getStaffOnProbation() {
    return staffList.where((s) => s.isOnProbation()).toList();
  }

  /// Get nurses on duty for a specific shift
  List<Nurse> getDutyToday(String shift) {
    return staffList.where((s) => s is Nurse && s.shift == shift).cast<Nurse>().toList(); 
  }

  /// Save all staff to JSON files (for backup or after bulk changes)
  void saveAllStaff() {
    repository.saveAllStaff(staffList);
  }
}
