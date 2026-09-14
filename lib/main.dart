import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Kabataku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        fontFamily: 'Roboto',
      ),
      home: const KalkulatorPage(),
    );
  }
}

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();

  String _hasil = '0';
  String? _operatorAktif;

  static const Color _bgDark = Color(0xFF121212);
  static const Color _cardDark = Color(0xFF1E1E1E);
  static const Color _accent = Color(0xFF00E5A0);

  void _hitung(String operator) {
    double angka1 = double.tryParse(_angka1Controller.text) ?? 0;
    double angka2 = double.tryParse(_angka2Controller.text) ?? 0;
    double hasilOperasi = 0;

    setState(() {
      _operatorAktif = operator;

      switch (operator) {
        case 'kali':
          hasilOperasi = angka1 * angka2;
          break;
        case 'bagi':
          if (angka2 == 0) {
            _hasil = 'Tidak bisa dibagi 0';
            return;
          }
          hasilOperasi = angka1 / angka2;
          break;
        case 'tambah':
          hasilOperasi = angka1 + angka2;
          break;
        case 'kurang':
          hasilOperasi = angka1 - angka2;
          break;
      }

      if (hasilOperasi == hasilOperasi.toInt()) {
        _hasil = hasilOperasi.toInt().toString();
      } else {
        _hasil = hasilOperasi.toString();
      }
    });
  }

  void _reset() {
    setState(() {
      _angka1Controller.clear();
      _angka2Controller.clear();
      _hasil = '0';
      _operatorAktif = null;
    });
  }

  String _simbolOperator(String op) {
    switch (op) {
      case 'kali':
        return '×';
      case 'bagi':
        return '÷';
      case 'tambah':
        return '+';
      case 'kurang':
        return '−';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return Container(
      decoration: BoxDecoration(
        color: _cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String operator, String label, Color color) {
    final bool aktif = _operatorAktif == operator;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: GestureDetector(
          onTap: () => _hitung(operator),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: aktif
                    ? [color, color.withOpacity(0.6)]
                    : [_cardDark, _cardDark],
              ),
              border: Border.all(
                color: aktif ? color : Colors.white12,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: aktif ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kabataku',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  IconButton(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh_rounded,
                        color: Colors.white54),
                  ),
                ],
              ),
              const Text(
                'Kali · Bagi · Tambah · Kurang',
                style: TextStyle(color: Colors.white38, fontSize: 13),
              ),

              const SizedBox(height: 24),

              // Kartu hasil bergaya "layar kalkulator"
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1B3A32), Color(0xFF102420)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _accent.withOpacity(0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${_angka1Controller.text.isEmpty ? "0" : _angka1Controller.text} '
                      '${_operatorAktif != null ? _simbolOperator(_operatorAktif!) : ""} '
                      '${_angka2Controller.text.isEmpty ? "0" : _angka2Controller.text}',
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _hasil,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Input angka
              _buildInputField(_angka1Controller, 'Angka 1'),
              const SizedBox(height: 14),
              _buildInputField(_angka2Controller, 'Angka 2'),

              const SizedBox(height: 28),

              // Tombol operasi
              Row(
                children: [
                  _buildOperatorButton('tambah', '+', const Color(0xFF00E5A0)),
                  _buildOperatorButton('kurang', '−', const Color(0xFFFF6B6B)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildOperatorButton('kali', '×', const Color(0xFFFFC94D)),
                  _buildOperatorButton('bagi', '÷', const Color(0xFF64B5F6)),
                ],
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}