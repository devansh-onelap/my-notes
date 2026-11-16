import 'package:material_ui/material_ui.dart';

void stack_exmaple() {
  runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/images/logo.jpeg"),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white,
                              width: 2
                          )
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      )
  );
}