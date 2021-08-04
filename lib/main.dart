import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'home.dart';

late List<CameraDescription> camera;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  camera = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Mask',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
