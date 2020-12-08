import 'package:flutter/material.dart';
import 'package:ose_settings_application/Views/SubSettingsList.dart';

class Language extends StatelessWidget {

  final header = 'LANGUAGE';
  final List<String> _title = ['Menu Languages','Keyboard Languages'];
  final List<String> _subtitle = ['English - United States','English'];

  @override
  Widget build(BuildContext context) {
    return _subSettingsList();
  }

  Widget _subSettingsList(){
    return SubSettingsList(
        heading: header,
        title:_title,
        subTitle: _subtitle
    );
  }
}
