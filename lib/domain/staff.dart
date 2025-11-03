import 'payroll.dart';
import 'doctor.dart';
import 'nurse.dart';
import 'adminstrative_staff.dart';


enum Position { Doctor, Nurse, Administrative }
enum Gender { Male, Female }
enum Role { Receptionist, Accountant }

abstract class Staff {
  static int _counterDoctor = 0;
  static int _counterNurse = 0;
  static int _counterReceptionist = 0;
  static int _counterAccountant = 0;

  final String ID;
  String name;
  final Gender gender;
  final DateTime dob;
  double salary;
  final Position position;
  final DateTime hireDate;
  Payroll payroll;

  Staff(
    this.name,
    this.dob,
    this.gender,
    this.salary,
    this.position,
    this.hireDate,
    this.payroll,
  ) : ID = _generateDisplayID(position, null);

  // For Administrative staff
  Staff.admin(
    this.name,
    this.dob,
    this.gender,
    this.salary,
    this.hireDate,
    this.payroll,
    Role role,
  )   : position = Position.Administrative,
        ID = _generateDisplayID(Position.Administrative, role);

  static String _generateDisplayID(Position position, [Role? role]) {
    switch (position) {
      case Position.Doctor:
        _counterDoctor++;
        return 'DOC${_counterDoctor.toString().padLeft(3, '0')}';
      case Position.Nurse:
        _counterNurse++;
        return 'NUR${_counterNurse.toString().padLeft(3, '0')}';
      case Position.Administrative:
        if (role == Role.Receptionist) {
          _counterReceptionist++;
          return 'REC${_counterReceptionist.toString().padLeft(3, '0')}';
        } else if (role == Role.Accountant) {
          _counterAccountant++;
          return 'ACC${_counterAccountant.toString().padLeft(3, '0')}';
        } else {
          throw Exception('Administrative staff must have a role.');
        }
    }
  }

  // Abstract methods
  void displayInfo();
  double calculateBonus();
  double calculateSalaryWithOvertime(double hours);
  void updateInfo(String name);
  bool isOnProbation();
  int getWorkingYears();

  // JSON serialization
  Map<String, dynamic> toJson();

  factory Staff.fromJson(Map<String, dynamic> json) {
    switch (json['position']) {
      case 'Doctor':
        return Doctor.fromJson(json);
      case 'Nurse':
        return Nurse.fromJson(json);
      case 'Administrative':
        return AdministrativeStaff.fromJson(json);
      default:
        throw Exception('Unknown position: ${json['position']}');
    }
  }
}
