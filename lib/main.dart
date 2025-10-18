import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  const KalkulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "KALKULATOR BMI",
      debugShowCheckedModeBanner: false,
      home: KalkulatorScreen(),
    );
  }
}

class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({super.key});

  @override
  State<KalkulatorScreen> createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _selectedGender = 'Perempuan';

  double? _bmiResult;
  String _bmiInterpretation = "Silakan masukkan data Anda";

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightInCM = double.tryParse(_heightController.text) ?? 0;

    if (weight == 0 || heightInCM == 0) {
      setState(() {
        _bmiResult = null;
        _bmiInterpretation = "Data tidak valid!";
      });
      return;
    }

    setState(() {
      final double heightInM = heightInCM / 100;
      final double bmi = weight / (heightInM * heightInM);
      _bmiResult = bmi;

      if (_selectedGender == 'Laki-laki') {
        if (bmi < 18.5) {
          _bmiInterpretation = "Kurus (Laki-laki)";
        } else if (bmi < 25) {
          _bmiInterpretation = "Ideal (Laki-laki)";
        } else if (bmi < 30) {
          _bmiInterpretation = "Berlebih (Laki-laki)";
        } else {
          _bmiInterpretation = "Obesitas (Laki-laki)";
        }
      } else {
        if (bmi < 17.5) {
          _bmiInterpretation = "Kurus (Perempuan)";
        } else if (bmi < 24) {
          _bmiInterpretation = "Ideal (Perempuan)";
        } else if (bmi < 29) {
          _bmiInterpretation = "Berlebih (Perempuan)";
        } else {
          _bmiInterpretation = "Obesitas (Perempuan)";
        }
      }
    });
  }

  void _resetFields() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _bmiResult = null;
      _bmiInterpretation = "Silakan masukkan data Anda";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8E8EE),
      appBar: AppBar(
        title: const Text("KALKULATOR BMI"),
        centerTitle: true,
        backgroundColor: const Color(0xFFF4A6C1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Masukkan Data Anda",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB83B5E),
              ),
            ),
            const SizedBox(height: 20),

            // Input Berat
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Berat Badan (kg)",
                prefixIcon: const Icon(Icons.monitor_weight),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input Tinggi
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tinggi Badan (cm)",
                prefixIcon: const Icon(Icons.height),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Pilih Jenis Kelamin
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: InputDecoration(
                labelText: "Jenis Kelamin",
                prefixIcon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: ['Perempuan', 'Laki-laki']
                  .map(
                    (gender) =>
                        DropdownMenuItem(value: gender, child: Text(gender)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            // Tombol Hitung dan Reset
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _calculateBMI,
                  icon: const Icon(Icons.calculate),
                  label: const Text("Hitung BMI"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF4A6C1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _resetFields,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Hasil BMI
            const Text(
              "Hasil BMI Anda",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B4D),
              ),
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    _bmiResult?.toStringAsFixed(1) ?? "--",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB83B5E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _bmiInterpretation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
