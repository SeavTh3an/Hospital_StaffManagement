class Payroll {
  double tax;
  double insurance;
  double retire;

  Payroll({
    required this.tax,
    required this.insurance,
    required this.retire,
  });

  double calculateNetSalary(double baseSalary, {double bonus = 0.0}) {
    final gross = baseSalary + bonus;
    final deduction = gross * (tax + insurance + retire);
    return gross - deduction;
  }
  // For JSON support
  factory Payroll.fromJson(Map<String, dynamic> json) {
    return Payroll(
      tax: json['tax'],
      insurance: json['insurance'],
      retire: json['retire'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tax': tax,
        'insurance': insurance,
        'retire': retire,
      };
}
