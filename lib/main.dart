import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: MainPage()));
}
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  TextField(controller: controller,), actions: [
        IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final name = controller.text;
              createUser(name);
            }),
      ]),
    );
  }
  Future<void> createUser(String name) async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(); // cria um id aleatório
    final json = {
      'name': name,
      'age': 30,
      'birthday': DateTime(1992, 03, 20),
    };
    await docUser.set(json);
  }
}