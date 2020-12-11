import 'package:flutter/material.dart';
import 'package:ose_settings_application/data/TimeZones.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

class TimeDate extends StatefulWidget {
  final Function setDate;
  final Function setTime;
  final Function setTimeZone;
  final String date;
  final String time;
  final String timeZone;
  TimeDate(this.setDate, this.setTime, this.setTimeZone, this.date, this.time, this.timeZone);

  @override
  _TimeDateState createState() => _TimeDateState();
}

class _TimeDateState extends State<TimeDate> {
  Timer _timer;
  var currentTime = new TimeOfDay.now();
  Map<String, String> dateTimeData = {};
  final header = 'TIME & DATE';
  var currentDateTime = new DateTime.now();
  bool userTime = false;
  bool isSwitched = false;
  bool userTimeDate = false;
  bool setCurrentTime = false;
  List<TimeZoneData> timeZones = List();
  Future zoneData;
  String userTimeZone;

  void initState() {
    super.initState();
    var dateParse = DateTime.parse(currentDateTime.toString());
    zoneData = loadTimeZone();
    userTimeZone = widget.timeZone == '' ? "${dateParse.timeZoneName}" : widget.timeZone;
    _timer = Timer.periodic(Duration(minutes: 1), _onTimeChange);
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onTimeChange(Timer timer) {
    setState(() {
      if(userTime == true){
        TimeOfDay newTime = currentTime.replacing(
            hour: currentTime.hour,
            minute: currentTime.minute + 1
        );
        currentTime = newTime;
      }
      else
        currentTime =TimeOfDay.now();
      onChangeTimeOrDate();
      widget.setDate(dateTimeData['time']);
    });
  }

  void getInitialTimeDate() {
    if(setCurrentTime == true || userTimeDate == true || widget.time == '') {
      setState(() {
        userTimeDate = false;
        setCurrentTime = false;
      });
      onChangeTimeOrDate();
    }
    else{
      setState(() {
        dateTimeData['date'] = widget.date;
        dateTimeData['time'] = widget.time;
        dateTimeData['time_zone'] = widget.timeZone;
      });
    }

  }

  void onChangeTimeOrDate(){
    var dateParse = DateTime.parse(currentDateTime.toString());
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(
          currentTime, alwaysUse24HourFormat: false);
      setState(() {
        dateTimeData['date'] = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
        dateTimeData['time'] = formattedTime;
        dateTimeData['time_zone'] = userTimeZone;
      });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: currentDateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != currentDateTime)
      setState(() {
        userTimeDate = true;
        currentDateTime = picked;
        onChangeTimeOrDate();
        widget.setTime(dateTimeData['time']);
        widget.setDate(dateTimeData['date']);
      });
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: currentTime
    );
    if (picked != null && picked != currentTime) {
      setState(() {
        userTime = true;
        userTimeDate = true;
        currentTime = picked;
        onChangeTimeOrDate();
        widget.setTime(dateTimeData['time']);
        widget.setDate(dateTimeData['date']);
      });
    }
  }

  void toggleSwitch(bool value) {
    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        setCurrentTime = true;
        userTime = false;
      });
    }
    else
    {
      setState(() {
        isSwitched = false;
        setCurrentTime = true;
        userTime = false;
      });
    }
    currentDateTime = new DateTime.now();
    currentTime = new TimeOfDay.now();
    onChangeTimeOrDate();
    setState(() {
      widget.setTime(dateTimeData['time']);
      widget.setDate(dateTimeData['date']);
    });
  }

  void setTimeZone(val){
    setState(() {
      dateTimeData['time_zone'] = val;
      userTimeZone = val;
    });
  }

  Future<String> _loadTimeZoneAsset() {
    return rootBundle.loadString('data/time_zones.json');
  }

  Future<String> loadTimeZone() async {
    String jsonTimeZones = await _loadTimeZoneAsset();
    var timeZoneJson = jsonDecode(jsonTimeZones)['timezones'] as List;
    setState(() {
      timeZones = timeZoneJson.map((zones) => TimeZoneData.fromJson(zones)).toList();
    });
    return "Loaded Successfully";
  }

  @override
  Widget build(BuildContext context) {
    return _subSettingsList();
  }

  Widget _subSettingsList(){
    getInitialTimeDate();
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
                Card(
                  color: Colors.black87,
                  child: ListTile(
                    hoverColor: Colors.pinkAccent,
                    title: Text('Set Automatically', style: TextStyle(fontSize: 20, color: Colors.white)),
                    trailing: Switch(
                            onChanged: toggleSwitch,
                            value: isSwitched,
                            activeColor: Colors.pinkAccent,
                            activeTrackColor: Colors.white,
                            inactiveThumbColor: Colors.pinkAccent,
                            inactiveTrackColor: Colors.white,
                          ),
                        ),
                ),
                Card(
                  color: Colors.black87,
                  child: ListTile(
                    enabled: isSwitched == true ? false : true,
                    hoverColor: Colors.pinkAccent,
                    title: Text('Date', style: TextStyle(fontSize: 20,
                              color: isSwitched == true
                                  ? Colors.white60
                                  : Colors.white)),
                    subtitle: Text(dateTimeData['date'], style: TextStyle(fontSize: 15, color: Colors.white60)),
                    trailing: Icon(Icons.arrow_drop_down_outlined,
                              color: isSwitched == true
                                  ? Colors.white60
                                  : Colors.white),
                    onTap: () {
                            _selectDate(context);
                          },
                        ),
                ),
                Card(
                  color: Colors.black87,
                        child: ListTile(
                          enabled: isSwitched == true ? false : true,
                          hoverColor: Colors.pinkAccent,
                          title: Text('Time', style: TextStyle(fontSize: 20,
                              color: isSwitched == true
                                  ? Colors.white60
                                  : Colors.white)),
                          subtitle: Text(dateTimeData['time'], style: TextStyle(
                              fontSize: 15, color: Colors.white60)),
                          trailing: Icon(Icons.arrow_drop_down_outlined,
                              color: isSwitched == true
                                  ? Colors.white60
                                  : Colors.white),
                          onTap: () {
                            _pickTime(context);
                          },
                        ),
                      ),
                Card(
                  color: Colors.black87,
                  child: ListTile(
                      enabled: isSwitched == true ? false : true,
                      hoverColor: Colors.pinkAccent,
                      title: Text('Time Zone', style: TextStyle(fontSize: 20, color: isSwitched == true ? Colors.white60 : Colors.white)),
                      subtitle: new DropdownButtonHideUnderline(
                          child: new FutureBuilder<String>(
                              future: zoneData,
                              builder: (context, snapshot) {
                                return DropdownButton(
                                  iconEnabledColor: Colors.white,
                                  dropdownColor: Colors.black87,
                                  focusColor: Colors.pinkAccent[400],
                                  items: timeZones.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.value, style: TextStyle(fontSize: 15, color: Colors.white60)), value: item.value,);
                                  }).toList(),
                                  onChanged: (newVal) {
                                    setState(() {
                                      userTimeZone = newVal;
                                      widget.setTimeZone(newVal);
                                    });
                                    },
                                  value: dateTimeData['time_zone'],
                                );
                              }
                              )
                      )
                  ),
                )
              ]
        )
    );
  }
}
