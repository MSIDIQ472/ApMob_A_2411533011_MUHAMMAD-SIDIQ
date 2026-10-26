import 'package:flutter/material.dart';

/// Tugas 2: Halaman profil (avatar, nama, email, tombol logout)
class ProfileScreen extends StatelessWidget {
  final String email;

  const ProfileScreen({super.key, this.email = 'budi@email.com'});

  String get _name {
    final n = email.split('@').first;
    if (n.isEmpty) return 'Budi';
    return n[0].toUpperCase() + n.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.amber.shade200,
                child: Icon(Icons.person, size: 60, color: Colors.amber.shade800),
              ),
              const SizedBox(height: 16),
              Text(_name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(email, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  onPressed: () {
                    // Kembali ke login & hapus semua halaman sebelumnya
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
