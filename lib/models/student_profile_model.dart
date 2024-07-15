import 'package:flutter/material.dart';

class StudentModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime admissionDate;
  final int paidFee;
  final int pendingFee;
  final int totalFee;
  final String qrCode; 

  StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.admissionDate,
    required this.paidFee,
    required this.pendingFee,
    required this.totalFee,
    required this.qrCode,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      admissionDate: DateTime.parse(json['admission_date']),
      paidFee: json['paid_fee'],
      pendingFee: json['pending_fee'],
      totalFee: json['total_fee'],
      qrCode: json['qrcode'],  // Adjust if the QR code format is different
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'admission_date': admissionDate.toIso8601String(),
    'paid_fee': paidFee,
    'pending_fee': pendingFee,
    'total_fee': totalFee,
    'qrcode': qrCode,
  };
}
