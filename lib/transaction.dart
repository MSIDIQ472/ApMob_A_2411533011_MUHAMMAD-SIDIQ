import 'package:flutter/material.dart';

/// Model data transaksi
class TransactionModel {
  final String title;
  final double amount;
  final bool isExpense; // true = pengeluaran, false = pemasukan
  final DateTime date;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.isExpense,
    required this.date,
  });
}

/// Penyimpanan data sederhana (in-memory) yang dipakai Dashboard,
/// Riwayat, dan halaman Tambah Transaksi.
class TransactionStore {
  static const double initialBalance = 5000000;

  static final ValueNotifier<List<TransactionModel>> transactions =
      ValueNotifier<List<TransactionModel>>([
    TransactionModel(
      title: 'Makan Siang',
      amount: 50000,
      isExpense: true,
      date: DateTime.now(),
    ),
  ]);

  static void add(TransactionModel t) {
    transactions.value = [t, ...transactions.value];
  }

  static double get balance {
    double total = initialBalance;
    for (final t in transactions.value) {
      total += t.isExpense ? -t.amount : t.amount;
    }
    return total;
  }
}

/// Format angka menjadi "Rp 5.000.000"
String formatRupiah(double value) {
  final s = value.abs().toStringAsFixed(0).replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (m) => '.',
      );
  return '${value < 0 ? '-' : ''}Rp $s';
}
