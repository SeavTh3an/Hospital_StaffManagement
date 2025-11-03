import 'dart:convert';
import 'dart:io';
import '../domain/staff.dart';

class StaffRepository {
  final Map<Position, String> _filePaths = {
    Position.Doctor: 'data/doctor.json',
    Position.Nurse: 'data/nurse.json',
    Position.Administrative: 'data/administrative.json',
  };

  List<Staff> loadAllStaff() {
    List<Staff> allStaff = [];
    for (var entry in _filePaths.entries) {
      final file = File(entry.value);
      if (file.existsSync()) {
        final jsonString = file.readAsStringSync();
        if (jsonString.trim().isNotEmpty) {
          final List data = json.decode(jsonString);
          allStaff.addAll(data.map((e) => Staff.fromJson(e)).toList());
        }
      }
    }
    return allStaff;
  }

  List<Staff> LoadStaffByPosition(Position position) {
    final filePath = _filePaths[position]!;
    final file = File(filePath);

    if (file.existsSync()) return [];
    final jsonString = file.readAsStringSync();
    if (jsonString.trim().isEmpty) return [];
    final List data = json.decode(jsonString);
    return data.map((e) => Staff.fromJson(e)).toList();
  }

    void saveStaffByPosition(Position pos, List<Staff> staffList) {
    final filePath = _filePaths[pos]!;
    final file = File(filePath);

    final jsonData = staffList.map((s) => s.toJson()).toList();

    file.createSync(recursive: true);
    file.writeAsStringSync(JsonEncoder.withIndent('  ').convert(jsonData));
  }

    void saveAllStaff(List<Staff> allStaff) {
    for (var pos in _filePaths.keys) {
      final filtered = allStaff.where((s) => s.position == pos).toList();
      saveStaffByPosition(pos, filtered);
    }
  }
}
