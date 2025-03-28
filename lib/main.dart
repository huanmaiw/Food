import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Provider/Bloc/count_bloc.dart';
import 'Provider/Bloc/home_bloc.dart';
import 'firebase_options.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp(),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(), // Khởi tạo Bloc
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CounterScreen(), // Bloc đã bao bọc CounterScreen
      ),
    );
  }}
