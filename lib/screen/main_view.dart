import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:vet_desktop/screen/stock_screen.dart';
import 'package:vet_desktop/widgets/background_widget.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /// Views to display
  List<Widget> views = [
    Center(
      child: Text('Account'),
    ),
    Center(
      child: Text('Account'),
    ),
    Center(
      child: Text('Settings'),
    ),
    StockScreen(),
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        /// You can use an AppBar if you want to
        //appBar: AppBar(
        //  title: const Text('App'),
        //),

        // The row is needed to display the current view
        body: Stack(
      children: [
        background(),
        Container(
          decoration: BoxDecoration(color: Color.fromARGB(126, 0, 0, 0)),
          child: Row(
            children: [
              /// Pretty similar to the BottomNavigationBar!
              SideNavigationBar(
                selectedIndex: selectedIndex,
                items: const [
                  SideNavigationBarItem(
                    icon: Icons.dashboard,
                    label: 'สมัครสมาชิกสำหรับลูกค้า',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.dashboard,
                    label: 'จองคิว',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.person,
                    label: 'ตรวจสอบคิว',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.settings,
                    label: 'สต็อคสินค้า',
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                theme: SideNavigationBarTheme(
                  backgroundColor: Colors.black,
                  togglerTheme: SideNavigationBarTogglerTheme.standard(),
                  itemTheme: SideNavigationBarItemTheme.standard(),
                  dividerTheme: SideNavigationBarDividerTheme.standard(),
                ),
              ),

              /// Make it take the rest of the available width
              Expanded(
                child: views.elementAt(selectedIndex),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
