import 'package:flutter/material.dart';
import 'transaction.dart';

/// Tugas 1: Halaman riwayat transaksi
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  String _formatDate(DateTime d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(d.day)}/${two(d.month)}/${d.year} ${two(d.hour)}:${two(d.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: Colors.amber,
      ),
      body: ValueListenableBuilder<List<TransactionModel>>(
        valueListenable: TransactionStore.transactions,
        builder: (context, list, _) {
          if (list.isEmpty) {
            return const Center(
              child: Text('Belum ada riwayat transaksi',
                  style: TextStyle(fontSize: 16)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final t = list[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      t.isExpense ? const Color(0xFFFEE2E2) : const Color(0xFFDCFCE7),
                  child: Icon(
                    t.isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                    color: t.isExpense ? Colors.red : Colors.green,
                  ),
                ),
                title: Text(t.title),
                subtitle: Text(_formatDate(t.date)),
                trailing: Text(
                  '${t.isExpense ? '- ' : '+ '}${formatRupiah(t.amount)}',
                  style: TextStyle(
                    color: t.isExpense ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
