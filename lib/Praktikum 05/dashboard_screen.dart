import 'package:flutter/material.dart';
import 'transaction.dart';

class DashboardScreen extends StatelessWidget {
  final String email;

  const DashboardScreen({super.key, this.email = 'budi@email.com'});

  String get _name {
    final n = email.split('@').first;
    if (n.isEmpty) return 'Budi';
    return n[0].toUpperCase() + n.substring(1);
  }

  Widget _quickAction(BuildContext context, IconData icon, Color color,
      Color bg) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.pushNamed(context, '/add'),
      child: Container(
        width: 56,
        height: 48,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // ===== Header =====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
            color: const Color(0xFFF59E0B),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Halo, $_name!',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 4),
                      ValueListenableBuilder<List<TransactionModel>>(
                        valueListenable: TransactionStore.transactions,
                        builder: (context, value, _) => Text(
                          formatRupiah(TransactionStore.balance),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(email,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
          ),

          // ===== Tombol aksi cepat =====
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _quickAction(context, Icons.arrow_downward,
                    Colors.amber.shade800, const Color(0xFFFEF3C7)),
                _quickAction(context, Icons.arrow_upward, Colors.red,
                    const Color(0xFFFEE2E2)),
                _quickAction(context, Icons.swap_horiz, Colors.blue,
                    const Color(0xFFDBEAFE)),
              ],
            ),
          ),

          // ===== Transaksi terakhir =====
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Transaksi Terakhir',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ValueListenableBuilder<List<TransactionModel>>(
              valueListenable: TransactionStore.transactions,
              builder: (context, list, _) {
                if (list.isEmpty) {
                  return const Center(child: Text('Belum ada transaksi'));
                }
                final recent = list.take(5).toList();
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: recent.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final t = recent[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFFEF3C7),
                        child: Icon(
                          t.isExpense ? Icons.restaurant : Icons.attach_money,
                          color: Colors.amber.shade800,
                          size: 20,
                        ),
                      ),
                      title: Text(t.title),
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
          ),
        ],
      ),

      // Pembaruan Modul 5: memakai Named Route
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: () {
          // Memanggil Rute yang sudah didaftarkan di main.dart
          Navigator.pushNamed(context, '/add');
        },
      ),
    );
  }
}
