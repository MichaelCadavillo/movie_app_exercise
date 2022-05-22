import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_exercise/bloc/navigation/navigation_cubit.dart';
import 'package:movie_app_exercise/screens/common/app_scaffold.dart';
import 'package:movie_app_exercise/screens/navigation/app_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      titleText: "HOME PAGE",
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("THIS IS THE HOME PAGE"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<NavigationCubit>(context)
                    .navigateTo(AppConfig.movie());
              },
              child: const Text(
                "MOVIE LIST",
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
