import 'package:flutter/material.dart';
import 'package:ose_settings_application/Views/SubSettingsList.dart';


class SystemInformation extends StatelessWidget {
  final header = 'SYSTEM INFORMATION';
  final List<String> _title = ['Device Name','Software Version', 'MAC Address (Wired)', 'MAC Address (Wireless)'];
  final List<String> _subtitle = ['webOS Opn Source Edition','2.8.g-clean.rpt-8117','DC:A6:32:2B:45:6A','DC:A6:32:2B:45:6B'];

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

