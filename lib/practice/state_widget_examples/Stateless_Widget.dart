import 'package:material_ui/material_ui.dart';

void main() {
  runApp(
      MaterialApp(
        home: Scaffold(
          body: WelcomeMessage(),
        ),
      )
  );
}

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Welcome to my notes");
  }
}