import 'package:flutter/material.dart';
import 'package:movie_app_exercise/screens/common/app_scaffold.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Title(
      title: "404 Page Not Found",
      color: Colors.black,
      child: const AppScaffold(
        titleText: "PAGE NOT FOUND",
        body: Center(
          child: Text('404 Error - Not Found'),
        ),
      ),
    );
  }
}
