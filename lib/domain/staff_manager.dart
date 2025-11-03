import 'staff.dart';
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
  void removeStaff(String id) {
    // Safely find staff by ID
    Staff? staffToRemove;
    for (var s in staffList) {
      if (s.ID == id) {
        staffToRemove = s;
        break;
      }
    }

    if (staffToRemove != null) {
      staffList.remove(staffToRemove);
      repository.saveStaffByPosition(
          staffToRemove.position, getStaffByPosition(staffToRemove.position));
    }
    // If not found, do nothing
  }

  /// Find a staff by ID
  Staff? findStaffById(String id) {
    for (var s in staffList) {
      if (s.ID == id) {
        return s;
      }
    }
    return null; // Not found
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
      total += s.salary; // or s.payroll.calculateNetSalary(s.salary) for net salary
    }
    return total;
  }

  /// Get staff who are still on probation
  List<Staff> getStaffOnProbation() {
    return staffList.where((s) => s.isOnProbation()).toList();
  }

  /// Save all staff to JSON files (for backup or after bulk changes)
  void saveAllStaff() {
    repository.saveAllStaff(staffList);
  }
}
