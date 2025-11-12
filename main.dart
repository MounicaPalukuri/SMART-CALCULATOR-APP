import 'package:flutter/material.dart';
void main() => runApp(const SmartCalc());

class SmartCalc extends StatefulWidget {
  const SmartCalc({super.key});
  @override State<SmartCalc> createState() => _SmartCalcState();
}

class _SmartCalcState extends State<SmartCalc> {
  final c1 = TextEditingController(), c2 = TextEditingController(), c3 = TextEditingController();
  String result = 'Result will appear here';

  num? n(TextEditingController c) => num.tryParse(c.text);
  void show(String r) => setState(() => result = r);

  void evenOdd() {
    var a = n(c1);
    show(a == null ? "⚠ Enter a number!" : (a % 2 == 0 ? "$a is Even ✅" : "$a is Odd 🔢"));
  }

  void factorial() {
    var a = n(c1);
    if (a == null || a < 0) return show("⚠ Positive only!");
    var f = 1; 
    for (int i = 1; i <= a; i++) {
      f *= i;
    }
    show("Factorial($a) = $f");
  }

  void lcm() {
    var a = n(c1), b = n(c2);
    if (a == null || b == null || a <= 0 || b <= 0) return show("⚠ Enter valid numbers!");
    int gcd(int x, int y) => y == 0 ? x : gcd(y, x % y);
    show("LCM($a,$b) = ${(a * b) ~/ gcd(a.toInt(), b.toInt())}");
  }

  void bmi() {
    var h = n(c1), w = n(c2);
    if (h == null || w == null || h <= 0) return show("⚠ Enter valid data!");
    var b = w / ((h / 100) * (h / 100));
    var s = b < 18.5 ? "Underweight 🏃" : b < 25 ? "Normal 😊" : b < 30 ? "Overweight ⚠" : "Obese 🚨";
    show("BMI = ${b.toStringAsFixed(2)} ($s)");
  }

  void interest() {
    var p = n(c1), t = n(c2), r = n(c3);
    if (p == null || t == null || r == null) return show("⚠ Enter P, T, R!");
    show("Simple Interest = ₹${(p * t * r / 100).toStringAsFixed(2)}");
  }

  Widget box(TextEditingController c, String hint) => TextField(
      controller: c, keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: hint, filled: true, fillColor: Colors.grey[850],
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      style: const TextStyle(color: Colors.white));

  Widget btn(String t, Color c, VoidCallback f) => ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: c, padding: const EdgeInsets.all(14)),
      onPressed: f, child: Text(t, style: const TextStyle(color: Colors.white)));

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(title: const Text("🧮 Smart Calculator"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(8)),
              child: Text(result, textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.greenAccent, fontSize: 18))),
            const SizedBox(height: 20),
            box(c1, "Num / Height / Principal"), const SizedBox(height: 10),
            box(c2, "Num / Weight / Time"), const SizedBox(height: 10),
            box(c3, "Rate (for Interest)"), const SizedBox(height: 20),
            Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
              btn("Even/Odd", Colors.orange, evenOdd),
              btn("Factorial", Colors.purple, factorial),
              btn("LCM", Colors.teal, lcm),
              btn("BMI", Colors.indigo, bmi),
              btn("Interest", Colors.redAccent, interest),
            ]),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700],
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12)),
              onPressed: () { c1.clear(); c2.clear(); c3.clear(); show("Result will appear here"); },
              child: const Text("CLEAR", style: TextStyle(color: Colors.white, fontSize: 18)))
          ]),
        ),
      ),
    ),
  );
}
