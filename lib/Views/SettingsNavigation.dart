import 'package:flutter/material.dart';
import 'package:ose_settings_application/Components/GeneralSettings.dart';
import 'package:ose_settings_application/Components/NetworkSettings.dart';
import 'package:intl/intl.dart';

class SettingsNavigation extends StatefulWidget {
  final int selectedIndex;
  final Widget subSettings;
  const SettingsNavigation({Key key, this.selectedIndex, this.subSettings})
      : super(key: key);
  @override
  _SettingsNavigationState createState() => _SettingsNavigationState();
}

class _SettingsNavigationState extends State<SettingsNavigation> {
  int selectedItem = 0;
  GeneralSettings generalSettings;
  Widget currentPage;
  String deviceName, date, time, dateTime;

  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    dateTime = DateFormat('kk:mm:ss EEE d MMM').format(now);
    date = '';
    time = '';
    generalSettings = GeneralSettings(this.callback, this.dateTime,
        this.setDate, this.setTime, this.date, this.time);
    currentPage = generalSettings;
    deviceName = 'webOS Open Source Edition';
  }

  void setDate(String data) {
    setState(() {
      this.date = data;
      this.dateTime = this.date + " " + this.time;
    });
  }

  void setTime(String data) {
    setState(() {
      this.time = data;
      this.dateTime = this.date + " " + this.time;
    });
  }

  void setDeviceName(String name) {
    setState(() {
      this.deviceName = name;
    });
  }

  void callback(Widget nextPage) {
    setState(() {
      this.currentPage = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          iconSize: 35,
          hoverColor: Colors.grey,
          onPressed: () {
            selectedItem == 0
                ? setState(() {
                    currentPage = GeneralSettings(
                      this.callback,
                      this.dateTime,
                      this.setDate,
                      this.setTime,
                      this.date,
                      this.time,
                    );
                  })
                : setState(() {
                    currentPage = NetworkSettings(
                        this.callback, this.deviceName, this.setDeviceName);
                  });
          },
        ),
        body: Row(
          children: <Widget>[
            NavigationRail(
              backgroundColor: Colors.black,
              selectedIndex: widget.selectedIndex == null
                  ? selectedItem
                  : widget.selectedIndex,
              selectedLabelTextStyle:
                  TextStyle(color: Colors.white, fontSize: 15),
              unselectedLabelTextStyle:
                  TextStyle(color: Colors.white, fontSize: 15),
              selectedIconTheme:
                  IconThemeData(color: Colors.pinkAccent, size: 45),
              unselectedIconTheme:
                  IconThemeData(color: Colors.black87, size: 45),
              labelType: NavigationRailLabelType.all,
              minWidth: 150,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedItem = index;
                  index == 0
                      ? setState(() {
                          currentPage = GeneralSettings(
                            this.callback,
                            this.dateTime,
                            this.setDate,
                            this.setTime,
                            this.date,
                            this.time,
                          );
                        })
                      : setState(() {
                          currentPage = NetworkSettings(this.callback,
                              this.deviceName, this.setDeviceName);
                        });
                });
              },
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.settings, color: Colors.white),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('General'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.more_horiz, color: Colors.white),
                  selectedIcon: Icon(Icons.more_horiz),
                  label: Text('Network'),
                ),
              ],
            ),
            VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(
                child: Center(child: currentPage
                    // widget.subSettings
                    ))
          ],
        ));
  }
}
