import 'package:flutter/material.dart';

class WifiConnection extends StatelessWidget {

  final header = 'Wi-Fi CONNECTION';
  final List<String> _title = ['Add a hidden wireless network','Connect via WPS PBC', 'Connect via WPS PIN','Advanced Wi-fi Settings'];

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
          body:
                ListView.builder(
                    itemCount: _title.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color:  Colors.black87,
                        child: ListTile(
                          hoverColor: Colors.pinkAccent,
                          title: Text(_title[index], style: TextStyle(fontSize: 20, color: Colors.white))
                        ),
                      );
                    }
                )
      );
    }

}
