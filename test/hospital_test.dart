import 'package:test/test.dart';
import 'package:my_first_project/domain/payroll.dart';
import 'package:my_first_project/domain/doctor.dart';
import 'package:my_first_project/domain/nurse.dart';
import 'package:my_first_project/domain/adminstrative_staff.dart';
import 'package:my_first_project/domain/staff.dart';
import 'package:my_first_project/domain/staff_manager.dart';
import 'package:my_first_project/data/staff_repository.dart';

// A lightweight test repository that avoids touching the real filesystem
class TestRepository extends StaffRepository {
  final List<Staff> initial;
  List<Staff>? lastSaved;

  TestRepository(this.initial);

  @override
  List<Staff> loadAllStaff() => List.from(initial);

  @override
  void saveAllStaff(List<Staff> allStaff) {
    lastSaved = List.from(allStaff);
  }
}

void main() {
  group('Payroll', () {
    test('calculateNetSalary works correctly', () {
      final payroll = Payroll(tax: 0.1, insurance: 0.05, retire: 0.02);
      final net = payroll.calculateNetSalary(1000.0, bonus: 100.0);
      // gross = 1100, deductions = 1100 * 0.17 = 187, net = 913
      expect(net, closeTo(913.0, 0.0001));
    });

    test('toJson/fromJson roundtrip', () {
      final payroll = Payroll(tax: 0.12, insurance: 0.06, retire: 0.03);
      final json = payroll.toJson();
      final from = Payroll.fromJson(json);
      expect(from.tax, equals(payroll.tax));
      expect(from.insurance, equals(payroll.insurance));
      expect(from.retire, equals(payroll.retire));
    });
  });

  group('Staff and subclasses', () {
    final doctorPayroll = Payroll(tax: 0.15, insurance: 0.08, retire: 0.05);
    final nursePayroll = Payroll(tax: 0.1, insurance: 0.05, retire: 0.03);
    final adminPayroll = Payroll(tax: 0.08, insurance: 0.04, retire: 0.02);

    late Doctor doc;
    late Nurse nurse;
    late AdministrativeStaff receptionist;
    late AdministrativeStaff accountant;

    setUp(() {
      doc = Doctor(
        name: 'Dr Test',
        dob: DateTime(1980, 1, 1),
        gender: Gender.Male,
        salary: 10000,
        hireDate: DateTime.now().subtract(Duration(days: 400)),
        specialization: 'TestSpecialty',
        experienceYears: 12,
        payroll: doctorPayroll,
      );

      nurse = Nurse(
        name: 'Nurse Test',
        dob: DateTime(1990, 1, 1),
        gender: Gender.Female,
        salary: 4000,
        hireDate: DateTime.now().subtract(Duration(days: 30)),
        shift: 'Night',
        payroll: nursePayroll,
      );

      receptionist = AdministrativeStaff(
        name: 'Recep',
        dob: DateTime(1995, 1, 1),
        gender: Gender.Female,
        salary: 3000,
        hireDate: DateTime.now().subtract(Duration(days: 10)),
        role: Role.Receptionist,
        payroll: adminPayroll,
      );

      accountant = AdministrativeStaff(
        name: 'Acct',
        dob: DateTime(1985, 1, 1),
        gender: Gender.Male,
        salary: 3500,
        hireDate: DateTime.now().subtract(Duration(days: 800)),
        role: Role.Accountant,
        payroll: adminPayroll,
      );
    });

    test('ID prefixes are correct', () {
      expect(doc.id.startsWith('DOC'), isTrue);
      expect(nurse.id.startsWith('NUR'), isTrue);
      expect(receptionist.id.startsWith('REC'), isTrue);
      expect(accountant.id.startsWith('ACC'), isTrue);
    });

    test('toJson/fromJson roundtrip for Doctor', () {
      final json = doc.toJson();
      final restored = Staff.fromJson(json);
      expect(restored, isA<Doctor>());
      final rdoc = restored as Doctor;
      expect(rdoc.name, equals(doc.name));
      expect(rdoc.specialization, equals(doc.specialization));
      expect(rdoc.experienceYears, equals(doc.experienceYears));
    });

    test('calculateBonus behaviors', () {
      // Doctor experience 12 -> 20% bonus
      expect(doc.calculateBonus(), closeTo(doc.salary * 0.20, 0.001));
      // Nurse night shift -> 10% bonus
      expect(nurse.calculateBonus(), closeTo(nurse.salary * 0.10, 0.001));
      // Admin roles
      expect(receptionist.calculateBonus(),
          closeTo(receptionist.salary * 0.3, 0.001));
      expect(
          accountant.calculateBonus(), closeTo(accountant.salary * 0.5, 0.001));
    });

    test('isOnProbation and working years', () {
      // nurse hired 30 days ago, probation < 90 days
      expect(nurse.isOnProbation(), isTrue);
      // doctor hired 400 days ago, not on probation
      expect(doc.isOnProbation(), isFalse);
      // working years for accountant (hireDate 800 days ago) should be >= 2
      expect(accountant.getWorkingYears() >= 2, isTrue);
    });
  });

  group('StaffManager integration', () {
    late Doctor doc1;
    late Nurse nurse1;
    late TestRepository repo;
    late StaffManager manager;

    setUp(() {
      doc1 = Doctor(
        name: 'Doc1',
        dob: DateTime(1975, 3, 3),
        gender: Gender.Male,
        salary: 9000,
        hireDate: DateTime.now().subtract(Duration(days: 1000)),
        specialization: 'Gen',
        experienceYears: 15,
        payroll: Payroll(tax: 0.15, insurance: 0.08, retire: 0.05),
      );

      nurse1 = Nurse(
        name: 'N1',
        dob: DateTime(1992, 6, 6),
        gender: Gender.Female,
        salary: 4500,
        hireDate: DateTime.now().subtract(Duration(days: 20)),
        shift: 'Day',
        payroll: Payroll(tax: 0.1, insurance: 0.05, retire: 0.03),
      );

      repo = TestRepository([doc1, nurse1]);
      manager = StaffManager(repository: repo);
    });

    test('loading and querying staff', () {
      expect(manager.staffList.length, equals(2));
      final docs = manager.getStaffByPosition(Position.Doctor);
      expect(docs.length, equals(1));
      expect(docs.first, isA<Doctor>());
    });

    test('updateSalary persists via repository', () {
      final id = doc1.id;
      final ok = manager.updateSalary(id, 10000.0);
      expect(ok, isTrue);
      expect(repo.lastSaved, isNotNull);
      final savedDoc = repo.lastSaved!.firstWhere((s) => s.id == id) as Doctor;
      expect(savedDoc.salary, equals(10000.0));
    });

    test('removeStaff works', () {
      final id = nurse1.id;
      final removed = manager.removeStaff(id);
      expect(removed, isTrue);
      expect(manager.findStaffById(id), isNull);
    });

    test('getTotalMonthlyPayroll sums net salaries', () {
      final total = manager.getTotalMonthlyPayroll();
      final expected = doc1.payroll.calculateNetSalary(doc1.salary) +
          nurse1.payroll.calculateNetSalary(nurse1.salary);
      expect(total, closeTo(expected, 0.01));
    });
  });
}
