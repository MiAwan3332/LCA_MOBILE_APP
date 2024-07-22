class StudentDetail {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String admission_date;
  final int paid_fee;
  final int pending_fee;
  final int total_fee;

  StudentDetail({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.admission_date,
    required this.paid_fee,
    required this.pending_fee,
    required this.total_fee,
  });

  factory StudentDetail.fromJson(Map<String, dynamic> json) {
    return StudentDetail(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      admission_date: json['admission_date'],
      paid_fee: json['paid_fee'],
      pending_fee: json['pending_fee'],
      total_fee: json['total_fee'],
    );
  }
}
