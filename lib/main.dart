import 'package:crewmeister_test/module/attendance/bloc/attendance_bloc.dart';
import 'package:crewmeister_test/module/attendance/ui/screen/absences_screen.dart';
import 'package:crewmeister_test/module/attendance/usecase/attendance_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceBloc(AttendanceUsecase()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AbsencesScreen(),
      ),
    );
  }
}
