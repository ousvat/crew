import 'package:Crew/screens/02-Home-Screen/components/home_screen_body.dart';
import 'package:Crew/screens/03-History-Screen/components/history_screen_body.dart';
import 'package:Crew/theme/icons/crew_icons_icons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  List<Widget> screens = [HomeScreenBody(), HistoryScreenBody()];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: screens[_selectedIndex],
      backgroundColor: Colors.blueGrey.shade50,
      bottomNavigationBar: Stack(
        overflow: Overflow.visible,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(CrewIcons.home),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(CrewIcons.history),
                  ),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(CrewIcons.gift),
                  ),
                  label: 'Rewards',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(CrewIcons.settings),
                  ),
                  label: 'Settings',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedItemColor: Theme.of(context).disabledColor,
              showUnselectedLabels: true,
              elevation: 10,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              showSelectedLabels: true,
              iconSize: 30,
              type: BottomNavigationBarType.fixed,
              onTap: _onItemTapped,
            ),
          ),
          Positioned(
            top: -5,
            left:
                (size.width / 4 * (_selectedIndex + 1)) - size.width / 8 - 12.5,
            child: Container(
              height: 10,
              width: 25,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ],
      ),
    );
  }

  _onItemTapped(int index) {
    setState(() {
      if (index < 2) _selectedIndex = index;
    });
  }
}
