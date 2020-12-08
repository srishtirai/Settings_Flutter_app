import 'package:flutter/material.dart';

class TimeDate extends StatefulWidget {
  final Function setDate;
  final Function setTime;
  final String date;
  final String time;
  TimeDate(this.setDate, this.setTime, this.date, this.time);

  @override
  _TimeDateState createState() => _TimeDateState();
}

class _TimeDateState extends State<TimeDate> {
  Map<String, String> dateTimeData = {};
  final header = 'TIME & DATE';
  var currentDateTime = new DateTime.now();
  var currentTime = new TimeOfDay.now();
  bool isSwitched = false;

  Map getCurrentDateTime() {
    var dateParse = DateTime.parse(currentDateTime.toString());
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(currentTime, alwaysUse24HourFormat: false);
    var data = {
      'date': "${dateParse.day}-${dateParse.month}-${dateParse.year}",
      'time': formattedTime,
      'time_zone': "${dateParse.timeZoneName}",
    };
    dateTimeData.addAll(data);
    return  dateTimeData;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: currentDateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != currentDateTime)
      setState(() {
        currentDateTime = picked;
        getCurrentDateTime();
        widget.setDate(dateTimeData['date']);
        if(widget.time == '' ) widget.setTime(dateTimeData['time']) ;
      });
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: currentTime
    );
    if (picked != null && picked != currentTime)
      setState(() {
        currentTime = picked;
        getCurrentDateTime();
        widget.setTime(dateTimeData['time']);
        if(widget.date == '' ) widget.setDate(dateTimeData['date']) ;
      });
  }

  void toggleSwitch(bool value) {

    if(isSwitched == false)
    {
      setState(() {
        isSwitched = true;
        currentDateTime = new DateTime.now();
        currentTime = new TimeOfDay.now();
      });
      getCurrentDateTime();
    }
    else
    {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _subSettingsList();
  }

  Widget _subSettingsList(){
    getCurrentDateTime();
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
                color:  Colors.black87,
                child: ListTile(
                  enabled: isSwitched == true ? false : true,
                  hoverColor: Colors.pinkAccent,
                  title: Text('Date', style: TextStyle(fontSize: 20, color: isSwitched == true ? Colors.white60  : Colors.white)),
                  subtitle: widget.date == '' ?
                  Text(dateTimeData['date'], style: TextStyle(fontSize: 15, color: Colors.white60)) :
                  Text(widget.date, style: TextStyle(fontSize: 15, color: Colors.white60)),
                  trailing: Icon(Icons.arrow_drop_down_outlined, color: isSwitched == true ? Colors.white60  : Colors.white),
                  onTap: (){
                    _selectDate(context);
                  },
                ),
              ),
              Card(
                color:  Colors.black87,
                child: ListTile(
                  enabled: isSwitched == true ? false : true,
                  hoverColor: Colors.pinkAccent,
                  title: Text('Time', style: TextStyle(fontSize: 20, color: isSwitched == true ? Colors.white60  : Colors.white)),
                  subtitle: widget.time == '' ?
                  Text(dateTimeData['time'], style: TextStyle(fontSize: 15, color: Colors.white60)) :
                  Text(widget.time, style: TextStyle(fontSize: 15, color: Colors.white60)),
                  trailing: Icon(Icons.arrow_drop_down_outlined, color: isSwitched == true ? Colors.white60  : Colors.white),
                  onTap: (){
                    _pickTime(context);
                  },
                ),
              ),
              Card(
                color:  Colors.black87,
                child: ListTile(
                  hoverColor: Colors.pinkAccent,
                  title: Text('Time Zone', style: TextStyle(fontSize: 20, color: Colors.white)),
                  subtitle: Text( dateTimeData['time_zone'], style: TextStyle(fontSize: 15, color: Colors.white60)),
                  trailing: Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
                  onTap: (){

                  },
                ),
              )
            ]
        )
    );
  }

}
