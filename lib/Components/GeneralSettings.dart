import 'package:flutter/material.dart';
import 'package:ose_settings_application/Components/Language.dart';
import 'package:ose_settings_application/Components/SystemInformation.dart';
import 'package:ose_settings_application/Components/TimeData.dart';

class GeneralSettings extends StatefulWidget {
  final Function callback;
  final String dateTime;
  final Function setDate;
  final Function setTime;
  final Function setTimeZone;
  final String date;
  final String time;
  final String timeZone;

  GeneralSettings(this.callback, this.dateTime, this.setDate, this.setTime, this.setTimeZone, this.date, this.time, this.timeZone);

  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  final String header ='GENERAL';
  final List<String> _title = ['Language', 'Time & Date', 'System Information'];
  List<String> _subtitle = ['English - United States', '', 'webOS Open Source Edition'];
  //
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
                  title: Text(_title[index], style: TextStyle(fontSize: 20, color: Colors.white)),
                  subtitle: _title[index] == 'Time & Date' ? Text(widget.dateTime , style: TextStyle(fontSize: 15, color: Colors.white60)) :
                            Text(_subtitle[index] , style: TextStyle(fontSize: 15, color: Colors.white60)),
                  onTap: () {
                    // Navigator.pushNamed(context, '/'+widget.title[index]);
                    switch(_title[index]){
                      case 'Language' : widget.callback(Language());
                      break;
                      case 'System Information' : widget.callback(SystemInformation());
                      break;
                      case 'Time & Date' : widget.callback(TimeDate(widget.setDate, widget.setTime,widget.setTimeZone, widget.date, widget.time, widget.timeZone));
                      break;
                    }
                  },
                ),
              );
            }
        )
    );
  }
}