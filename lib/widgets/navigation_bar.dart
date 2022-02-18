import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.list)),
        IconButton(onPressed: (){}, icon: Icon(Icons.note)),
        IconButton(onPressed: (){}, icon: Icon(Icons.check)),
      ],
    );
  }
}
