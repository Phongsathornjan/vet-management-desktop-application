import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:vet_desktop/screen/%E0%B8%B4bookqueuescreen.dart';
import 'package:vet_desktop/screen/edituser_screen.dart';
import 'package:vet_desktop/screen/stock_screen.dart';
import 'package:vet_desktop/widgets/background_widget.dart';

class MainViewManager extends StatefulWidget {
  MainViewManager({Key? key}) : super(key: key);

  @override
  _MainViewManagerState createState() => _MainViewManagerState();
}

class _MainViewManagerState extends State<MainViewManager> {
  /// Views to display
  List<Widget> views = [
    BookQueuePage(),
    StockScreen(),
    EditUserScreen(),
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
                    icon: Icons.calendar_month_outlined,
                    label: 'จองคิว',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.settings,
                    label: 'สต๊อกสินค้า',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.edit,
                    label: 'จัดการพนักงาน',
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
