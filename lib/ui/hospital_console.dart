import 'dart:io';

import '../domain/staff_manager.dart';
import '../domain/doctor.dart';
import '../domain/nurse.dart';
import '../domain/adminstrative_staff.dart';

class HospitalConsole {
  final StaffManager staffManager = StaffManager();

  void start() {
    int choice = -1;
    while (choice != 0) {
      print('\n================ Hospital Staff Management ================');
      print('1. Add Staff');
      print('2. Remove Staff');
      print('3. Display All Staff');
      print('4. Find Staff by ID');
      print('5. Update Salary');
      print('6. Get Total Monthly Payroll');
      print('7. Get Staff by Position');
      print('8. Display Nurses On Duty Today');
      print('9. List Staff on Probation');
      print('0. Exit');
      stdout.write('Enter choice: ');
      choice = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

      switch (choice) {
        case 1:
        //  addStaff();
          break;
        case 2:
          removeStaff();
          break;
        case 3:
          staffManager.displayAllStaff();
          break;
        case 4:
          findStaff();
          break;
        case 5:
          // updateSalary();
          break;
        case 6:
          print('Total Payroll: \$${staffManager.getTotalMonthlyPayroll().toStringAsFixed(2)}');
          break;
        case 7:
        //  getStaffByPosition();
          break;
        case 8:
        //  whoOnDuty();
          break;
        case 9:
        //  listStaffOnProbation();
          break;
        case 0:
          print('Goodbye!');
          break;
        default:
          print('Invalid choice.');
      }
    }
  }

  // void addStaff() {
  //   stdout.write('Enter ID: ');
  //   final id = stdin.readLineSync() ?? '';
  //   stdout.write('Enter Name: ');
  //   final name = stdin.readLineSync() ?? '';
  //   stdout.write('Enter Salary: ');
  //   final salary = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

  //   print('Choose Staff Type: 1) Doctor 2) Nurse 3) Administrative Staff');
  //   stdout.write('Enter option: ');
  //   final t = int.tryParse(stdin.readLineSync() ?? '') ?? 3;

  //   if (t == 1) {
  //     stdout.write('Enter Specialization: ');
  //     final sp = stdin.readLineSync() ?? '';
  //     stdout.write('Experience years: ');
  //     final exp = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  //     staffManager.addStaff(Doctor(id: id, name: name, salary: salary, specialization: sp, experienceYears: exp));
  //   } else if (t == 2) {
  //     stdout.write('Shift (morning/afternoon/night): ');
  //     final shift = (stdin.readLineSync() ?? '').toLowerCase();
  //     staffManager.addStaff(Nurse(id: id, name: name, salary: salary, shift: shift));
  //   } else {
  //     stdout.write('Role (accountant / receptionist): ');
  //     final role = stdin.readLineSync() ?? '';
  //     staffManager.addStaff(AdministrativeStaff(id: id, name: name, salary: salary, role: role));
  //   }

  //   print("Staff added successfully!");
  // }

  void removeStaff() {
    stdout.write('Enter Staff ID to remove: ');
    final id = stdin.readLineSync() ?? '';
    final result = staffManager.removeStaff(id);
    print(result ? "Removed." : "Staff not found");
  }

  void findStaff() {
    stdout.write('Enter Staff ID: ');
    final id = stdin.readLineSync() ?? '';
    final s = staffManager.findStaffById(id);
    if (s == null) {
      print("Not found");
    } else {
      s.displayInfo();
    }
  }

  // void updateSalary() {
  //   stdout.write('Enter Staff ID: ');
  //   final id = stdin.readLineSync() ?? '';
  //   stdout.write('Enter new Salary: ');
  //   final n = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;
  //   staffManager.updateSalary(id, n);
  //   print("Salary updated (if ID existed).");
  // }

  // void getStaffByPosition() {
  //   stdout.write('Enter Position (doctor / nurse / administrative): ');
  //   final p = stdin.readLineSync() ?? '';
  //   final pos = positionFromString(p);
  //   if (pos == null) {
  //     print('Unknown position.');
  //     return;
  //   }
  //   final list = staffManager.getStaffByPosition(pos);
  //   if (list.isEmpty) {
  //     print('No staff found for position: ${p}');
  //   } else {
  //     print('--- Staff in ${positionToString(pos)} position ---');
  //     for (var s in list) s.displayInfo();
  //   }
  // }

  // void whoOnDuty() {
  //   stdout.write('Enter shift to check (morning / afternoon / night): ');
  //   final shift = (stdin.readLineSync() ?? '').toLowerCase();
  //   final list = staffManager.getDutyToday(shift);
  //   if (list.isEmpty) {
  //     print('No one on duty for shift: $shift');
  //   } else {
  //     print('---- On Duty (shift: $shift) ----');
  //     for (var s in list) s.displayInfo();
  //   }
  // }

  
  // void listStaffOnProbation() {
  //   final probationStaff = staffManager.getStaffOnProbation();
  //   if (probationStaff.isEmpty) {
  //     print('No staff currently on probation.');
  //   } else {
  //     print('--- Staff on Probation ---');
  //     for (var s in probationStaff) {
  //       s.displayInfo();
  //     }
  //   }
  // }

}
