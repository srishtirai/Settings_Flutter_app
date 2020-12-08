import 'package:flutter/material.dart';
import 'package:ose_settings_application/Components/WiredConnection.dart';
import 'package:ose_settings_application/Components/WifiConnection.dart';

class NetworkSettings extends StatefulWidget {
  final Function callback;
  final Function setDeviceName;
  final String deviceName;
  NetworkSettings(this.callback, this.deviceName, this.setDeviceName);

  @override
  _NetworkSettingsState createState() => _NetworkSettingsState();
}

class _NetworkSettingsState extends State<NetworkSettings> {

  final header = 'NETWORK';
  String _deviceName = '';

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
          ListView(
              children: <Widget>[
                Card(
                  color:  Colors.black87,
                  child: ListTile(
                    hoverColor: Colors.pinkAccent,
                    title: Text('Device Name', style: TextStyle(fontSize: 20, color: Colors.white)),
                      trailing: Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
                        subtitle:
                    TextFormField(
                      scrollPadding: EdgeInsets.all(0) ,
                      style: TextStyle(fontSize: 15, color: Colors.white60),
                      cursorColor: Colors.pinkAccent,
                      initialValue: _deviceName == '' ? widget.deviceName : _deviceName ,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0,15,0,0),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), gapPadding: 10)
                      ),
                    onChanged: (text){
                      setState(() {
                       _deviceName = text;
                       widget.setDeviceName(text);
                      });
                  },
                    ),
                  )
                ),
                Card(
                  color:  Colors.black87,
                  child: ListTile(
                    hoverColor: Colors.pinkAccent,
                    title: Text('Wired Connection (Ethernet)', style: TextStyle(fontSize: 20, color: Colors.white)),
                    subtitle: Text('Connection Status', style: TextStyle(fontSize: 15, color: Colors.white60)),
                    onTap: () {
                      widget.callback(WiredConnection());
                    },
                  ),
                ),
                Card(
                  color:  Colors.black87,
                  child: ListTile(
                    hoverColor: Colors.pinkAccent,
                    title: Text('Wi-fi Connection', style: TextStyle(fontSize: 20, color: Colors.white)),
                    subtitle: Text('Connection Status', style: TextStyle(fontSize: 15, color: Colors.white60)),
                    onTap: () {
                      widget.callback(WifiConnection());
                    },
                  ),
                ),
              ]
          )
    );
  }
}

