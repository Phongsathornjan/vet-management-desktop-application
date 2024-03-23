import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:vet_desktop/screen/%E0%B8%B4bookqueuescreen.dart';
import 'package:vet_desktop/screen/registerscreen.dart';
import 'package:vet_desktop/screen/selling_screen.dart';
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
    RegisterScreen(),
    SellingScreen(),
    BookQueuePage(),
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
                    label: 'ลงทะเบียนสำหรับลูกค้า',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.sell_outlined,
                    label: 'ระบบขาย',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.calendar_month_outlined,
                    label: 'จองคิว',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.settings,
                    label: 'สต๊อกสินค้า',
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
