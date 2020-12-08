import 'package:flutter/material.dart';

class WiredConnection extends StatelessWidget {

  final String header = 'WIRED CONNECTION';
  final String message = 'Connect your device to your router or modem with an Ethernet cable to activate your wired network connection';

  @override
  Widget build(BuildContext context) {
    return _subSettingsList();
  }

  Widget _subSettingsList(){
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
            backgroundColor: Colors.black87,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            title: Text(header, style: TextStyle(fontSize: 50, color: Colors.white))
        ),
        body: Padding(child: Text(message, style: TextStyle(fontSize: 15, color: Colors.white)), padding: EdgeInsets.fromLTRB(0, 15, 0, 0))
    );
  }
}



