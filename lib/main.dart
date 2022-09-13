import 'dart:convert';
import 'dart:typed_data';

import 'package:floor_issue/issue/database.dart';
import 'package:floor_issue/issue/task.dart';
import 'package:flutter/material.dart';

late final AppDatabase database;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final taskDao = database.taskDao;
  final int taskId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  String source = 'hello';
                  List<int> list = utf8.encode(source);
                  Uint8List data = Uint8List.fromList(list);
                  await taskDao.insertTask(Task(taskId, data));

                  taskDao.findTaskById(taskId).then((value) {
                    print(
                        'insertTask ${value?.id}, ${utf8.decode(value?.data ?? Uint8List(0))}');
                  });
                },
                child: const Text(
                  'insertTask',
                )),
            ElevatedButton(
                onPressed: () async {
                  String source = 'new_hello';
                  List<int> list = utf8.encode(source);
                  Uint8List data = Uint8List.fromList(list);
                  await taskDao.rawUpdateData(data, taskId);
                  taskDao.findTaskById(taskId).then((value) {
                    print(
                        'updateTask ${value?.id}, ${utf8.decode(value?.data ?? Uint8List(0))}');
                  });
                },
                child: const Text(
                  'updateTask',
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
