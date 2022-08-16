import 'package:flutter/material.dart';

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;

  const NavigationItem({
    required this.route,
    required this.label,
    required this.icon,
  });
}

final List<NavigationItem> items = [
  const NavigationItem(
    icon: Icons.home,
    label: 'Inicio',
    route: '/home',
  ),
  const NavigationItem(
    icon: Icons.schedule,
    label: 'Histórico',
    route: '/history',
  )
];

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    int currentIndex = 0;

    for (int index = 0; index < items.length; index++) {
      if (items[index].route == currentRoute) currentIndex = index;
    }

    void changeRoute(int index) {
      String nextRoute = items[index].route;
      if (currentRoute != nextRoute) {
        Navigator.pushNamed(context, nextRoute);
      }

      setState(() {
        currentIndex = index;
      });
    }

    return BottomNavigationBar(
      items: items.map((e) {
        return BottomNavigationBarItem(
          icon: Icon(e.icon),
          label: e.label,
        );
      }).toList(),
      currentIndex: currentIndex,
      onTap: changeRoute,
    );
  }
}
