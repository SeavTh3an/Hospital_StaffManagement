import 'package:uuid/uuid.dart';

enum Position { Doctor, Nurse, Administrative }

enum Role { Receptionist, Accountant }

enum Department {
  Liver,
  Heart,
  Brain,
}

abstract class Staff {
  static final _uuid = Uuid();
  static int _counterDoctor = 0;
  static int _counterNurse = 0;
  static int _counterReceptionist = 0;
  static int _counterAccountant = 0;

  final String id; // Internal UUID
  final String displayID; // Human-friendly ID
  String name;
  final DateTime dob;
  final String gender;
  double salary;
  final Position position;
  final DateTime hireDate;

  Staff(
    this.name,
    this.dob,
    this.gender,
    this.salary,
    this.position,
    this.hireDate,
  )   : id = _uuid.v4(),
        displayID = _generateDisplayID(position, null); // Default null role for non-admins

  // For Administrative Staff, pass Role
  Staff.admin(
    this.name,
    this.dob,
    this.gender,
    this.salary,
    this.hireDate,
    Role role,
  )   : id = _uuid.v4(),
        position = Position.Administrative,
        displayID = _generateDisplayID(Position.Administrative, role);

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
    void displayInfo() {
    print('ID: $id');
    print('DisplayID: $displayID');
    print('Name: $name');
    print('Position: ${position.name}');
    print('Salary: $salary');
    print('Hire Date: $hireDate');
  }
  double calculateBonus();
}

