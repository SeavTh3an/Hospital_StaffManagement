class Payroll {
  double tax;
  double insurance;
  double retire;
  double bonus;

  Payroll({
    required this.tax,
    required this.insurance,
    required this.retire,
    required this.bonus,
  });

  double calculatePayroll(double baseSalary) {
    throw UnimplementedError();
  }
}
