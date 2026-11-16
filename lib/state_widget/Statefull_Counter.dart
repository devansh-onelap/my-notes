import 'package:material_ui/material_ui.dart';

void main() {
  runApp(
      MaterialApp(
        home: Scaffold(
            body: Counter()
        ),
      )
  );
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Count: $count"),
          ElevatedButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            child: Text("Increment"),
          )
        ],
      ),
    );
  }
}