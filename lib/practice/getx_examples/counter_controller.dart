import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

// 1. CONTROLLER: holds state + logic (think @Service)
class CounterController extends GetxController {
  final count = 0.obs;            // observable state

  void increment() => count.value++;   // business logic
}

// 2. UI: displays state, forwards events
class CounterScreen extends StatelessWidget {   // note: Stateless!
  CounterScreen({super.key});

  // 3. DEPENDENCY INJECTION: register + get the controller
  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    print("App build");
    return Scaffold(
      appBar: AppBar(title: const Text("Counter")),   // never rebuilds
      body: Center(
        // 4. OBSERVER: only this widget rebuilds when count changes
        child: Obx(() => Text("Count: ${controller.count.value}")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}