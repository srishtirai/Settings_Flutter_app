import 'package:flutter/material.dart';

class WifiConnection extends StatelessWidget {
  final header = 'Wi-Fi CONNECTION';
  final List<String> _title = ['Add a hidden wireless network','Connect via WPS PBC', 'Connect via WPS PIN','Advanced Wi-fi Settings'];
  final List<String> network_list = ['QE4_GOOGLe','idjhopjrewoe-j', 'Jio 32','Cspapps', 'vivo 5621','erftrj', 'jhsaeofw','idjhopjrewoe-j', 'jhsaeofw','idjhopjrewoe-j', 'jhsaeofw','idjhopjrewoe-j'];
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
          body:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 300,
                  child:  ListView.builder(
                      itemCount:network_list.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color:  Colors.black87,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                            child:ListTile(
                              hoverColor: Colors.pinkAccent[400],
                              title: Text(network_list[index], style: TextStyle(fontSize: 20, color: Colors.white)),
                              trailing: Icon(Icons.signal_wifi_4_bar_lock_sharp, color: Colors.white),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ListTile(
                hoverColor: Colors.pinkAccent,
                title: Text(_title[0], style: TextStyle(fontSize: 20, color: Colors.white))
              ),
                ListTile(
                    hoverColor: Colors.pinkAccent,
                    title: Text(_title[1], style: TextStyle(fontSize: 20, color: Colors.white))
                ),
                ListTile(
                    hoverColor: Colors.pinkAccent,
                    title: Text(_title[2], style: TextStyle(fontSize: 20, color: Colors.white))
                ),
                ListTile(
                    hoverColor: Colors.pinkAccent,
                    title: Text(_title[3], style: TextStyle(fontSize: 20, color: Colors.white))
                ),
        ]
          )
    );

    }

}
