import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'task_form.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'to_do_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("accountList");
  await Hive.openBox("todoList");
  runApp(const LegendaryRoutes());
}

class LegendaryRoutes extends StatelessWidget {
  const LegendaryRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 27, 66, 88),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const TodoListScreen(),
        '/addTask': (context) => const TaskForm(),
        '/editTask': (context) => const TaskForm(),
      },
    );
  }
}
