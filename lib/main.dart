import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_exercise/bloc/navigation/navigation_cubit.dart';
import 'package:movie_app_exercise/screens/navigation/app_route_information_parser.dart';
import 'package:movie_app_exercise/screens/navigation/app_router_delegate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouterDelegate _routerDelegate = AppRouterDelegate();
  final AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (BuildContext context) => NavigationCubit(),
      child: MaterialApp.router(
          title: 'Movie App Exercise',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              color: Color(0xFFF1F1F1),
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0,
            ),
          ),
          routeInformationParser: _routeInformationParser,
          routerDelegate: _routerDelegate),
    );
  }
}
