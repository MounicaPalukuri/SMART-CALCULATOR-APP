import 'package:flutter/material.dart';
void main() => runApp(const SmartCalcApp());

class SmartCalcApp extends StatefulWidget {
  const SmartCalcApp({super.key});
  @override
  State<SmartCalcApp> createState() => _SmartCalcAppState();
}

class _SmartCalcAppState extends State<SmartCalcApp> {
  final c1 = TextEditingController(), c2 = TextEditingController(), c3 = TextEditingController();
  String result = 'Result will appear here';

  void evenOdd() {
    final a = int.tryParse(c1.text);
    setState(() => result = (a == null) ? "⚠ Enter a valid integer!" : (a % 2 == 0 ? "$a is Even ✅" : "$a is Odd 🔢"));
  }

  void factorial() {
    final a = int.tryParse(c1.text);
    if (a == null || a < 0) return setState(() => result = "⚠ Enter a positive number!");
    int f = 1; for (int i = 1; i <= a; i++) {
      f *= i;
    }
    setState(() => result = "Factorial($a) = $f");
  }

  void lcm() {
    final a = int.tryParse(c1.text), b = int.tryParse(c2.text);
    if (a == null || b == null || a <= 0 || b <= 0) return setState(() => result = "⚠ Enter valid numbers!");
    int gcd(int x, int y) => y == 0 ? x : gcd(y, x % y);
    setState(() => result = "LCM($a,$b) = ${(a * b) ~/ gcd(a, b)}");
  }

  void bmi() {
    final h = double.tryParse(c1.text), w = double.tryParse(c2.text);
    if (h == null || w == null || h <= 0) return setState(() => result = "⚠ Enter valid height & weight!");
    final bmi = w / ((h / 100) * (h / 100));
    final s = bmi < 18.5 ? "Underweight 🏃" : bmi < 25 ? "Normal 😊" : bmi < 30 ? "Overweight ⚠" : "Obese 🚨";
    setState(() => result = "BMI = ${bmi.toStringAsFixed(2)} ($s)");
  }

  void interest() {
    final p = double.tryParse(c1.text), t = double.tryParse(c2.text), r = double.tryParse(c3.text);
    if (p == null || t == null || r == null) return setState(() => result = "⚠ Enter P, T, R!");
    setState(() => result = "Simple Interest = ₹${(p * t * r / 100).toStringAsFixed(2)}");
  }

  void clear() {
    c1.clear(); c2.clear(); c3.clear();
    setState(() => result = 'Result will appear here');
  }

  Widget box(TextEditingController c, String hint) => TextField(
        controller: c,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.grey[850],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

  Widget btn(String text, Color color, VoidCallback onTap) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color, padding: const EdgeInsets.all(16)),
        onPressed: onTap,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      );

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFF1E1E1E),
          appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text("🧮 Smart Function Calculator")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(result,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.greenAccent, fontSize: 18)),
                ),
                const SizedBox(height: 20),
                box(c1, "Enter number / height / principal"),
                const SizedBox(height: 10),
                box(c2, "Enter number / weight / time"),
                const SizedBox(height: 10),
                box(c3, "Enter rate (for Interest only)"),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    btn("Even/Odd", Colors.orange, evenOdd),
                    btn("Factorial", Colors.purple, factorial),
                    btn("LCM", Colors.teal, lcm),
                    btn("BMI", Colors.indigo, bmi),
                    btn("Interest", Colors.redAccent, interest),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 12)),
                  onPressed: clear,
                  child: const Text("CLEAR",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ]),
            ),
          ),
        ),
      );
}
