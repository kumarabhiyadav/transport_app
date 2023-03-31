import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/authModule/Bottom_navigations.dart';
import 'package:transport_app/authModule/screens/profile_screen.dart';
import 'package:transport_app/classroomModule/providers/classroom_provider.dart';
import 'package:transport_app/communityModule/screens/communityScreen.dart';
import 'package:transport_app/homeModule/home_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ClassRoomProvider())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'transport',
        home: BottomNavigations(),
      ),
    );
  }
}
