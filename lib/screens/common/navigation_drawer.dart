import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_exercise/bloc/navigation/navigation_cubit.dart';
import 'package:movie_app_exercise/screens/navigation/app_config.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: const Text('Home Page'),
            onTap: () {
              BlocProvider.of<NavigationCubit>(context)
                  .navigateTo(AppConfig.home());
            },
          ),
          ListTile(
            title: const Text('Movies'),
            onTap: () {
              BlocProvider.of<NavigationCubit>(context)
                  .navigateTo(AppConfig.movie());
            },
          ),
        ],
      ),
    );
  }
}
