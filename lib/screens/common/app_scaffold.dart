import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {Key? key,
      this.body,
      this.titleText = '',
      this.leading,
      this.hasDrawer = true,
      this.hasRefreshButton = false,
      this.onRefresh})
      : super(key: key);
  final Widget? body;
  final String titleText;
  final Widget? leading;
  final bool hasDrawer;
  final bool hasRefreshButton;
  final Function? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // drawer: hasDrawer ? const NavigationDrawer() : null,
        appBar: AppBar(
          title: Center(
              child: Text(
            titleText,
            style: const TextStyle(
                fontFamily: "Anton",
                color: Colors.black,
                letterSpacing: 3,
                fontSize: 30,
                fontWeight: FontWeight.w100),
          )),
          leading: leading,
          actions: hasRefreshButton
              ? [
                  IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (onRefresh != null) onRefresh!();
                    },
                  )
                ]
              : null,
        ),
        backgroundColor: const Color(0xFFF1F1F1),
        body: body);
  }
}
