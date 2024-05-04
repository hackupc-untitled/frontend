import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gnss2/Prefabs/CustomButton.dart';
import 'package:gnss2/WebService/WebService.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raw_gnss/gnss_status_model.dart';
import 'package:raw_gnss/raw_gnss.dart';
import 'package:intl/intl.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
        ),
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _macAddress = '';
  final _getMacAddressPlugin = '';
  var _hasPermissions = false;
  late RawGnss _gnss;

  @override
  void initState() {
    initMac();
    super.initState();

    RawGnss().gnssMeasurementEvents.listen((e) {
      Map<String, dynamic> fields = {};
      Map<String, dynamic> tags = {};

      print("raw");
      e.measurements?.forEach((element) {
        Map<String, dynamic> data = {
          'contents': element.contents,
          'accumulatedDeltaRangeMeters': element.accumulatedDeltaRangeMeters,
          'accumulatedDeltaRangeState': element.accumulatedDeltaRangeState,
          'accumulatedDeltaRangeUncertaintyMeters':
              element.accumulatedDeltaRangeUncertaintyMeters,
          'automaticGainControlLevelDb': element.automaticGainControlLevelDb,
          'carrierFrequencyHz': element.carrierFrequencyHz,
          'cn0DbHz': element.cn0DbHz,
          'constellationType': element.constellationType,
          'multipathIndicator': element.multipathIndicator,
          'pseudorangeRateMetersPerSecond':
              element.pseudorangeRateMetersPerSecond,
          'pseudorangeRateUncertaintyMetersPerSecond':
              element.pseudorangeRateUncertaintyMetersPerSecond,
          'receivedSvTimeNanos': element.receivedSvTimeNanos,
          'receivedSvTimeUncertaintyNanos':
              element.receivedSvTimeUncertaintyNanos,
          'snrInDb': element.snrInDb,
          'state': element.state,
          'svid': element.svid,
          'timeOffsetNanos': element.timeOffsetNanos
        };

        data.forEach((key, value) {
          if (isString(value)) {
            tags[key] = value;
          } else if (isDouble(value) || isInteger(value)) {
            fields[key] = value;
          }
        });
        tags['mac-address'] = _macAddress;
        tags["date"] = nowDate();
      });
      WebService.send("measurement", tags, fields);
    });

    /*RawGnss().gnssNavigationMessageEvents.listen((e) {
      print("navigation");
      print(e.string.toString());
    });*/

    RawGnss().gnssStatusEvents.listen((e) {
      Map<String, dynamic> fields = {};
      Map<String, dynamic> tags = {};

      print("raw");
      e.status?.forEach((element) {
        Map<String, dynamic> data = {
          'azimuthDegrees': element.azimuthDegrees.toString(),
          'carrierFrequencyHz': element.carrierFrequencyHz.toString(),
          'cn0DbHz': element.cn0DbHz.toString(),
          'constellationType': element.constellationType,
          'elevationDegrees': element.elevationDegrees.toString(),
          'svid': element.svid.toString(),
          'hasAlmanacData': element.hasAlmanacData.toString(),
          'hasCarrierFrequencyHz': element.hasCarrierFrequencyHz.toString(),
          'hasEphemerisData': element.hasEphemerisData.toString(),
          'usedInFix': element.usedInFix.toString(),
        };

        data.forEach((key, value) {
          if (isString(value)) {
            tags[key] = value;
          } else if (isDouble(value) || isInteger(value)) {
            fields[key] = value;
          }
        });
      });
      tags['mac-address'] = _macAddress;
      tags["date"] = nowDate();
      WebService.send("measurement", tags, fields);
    });

    Permission.location
        .request()
        .then((value) => setState(() => _hasPermissions = value.isGranted));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          CustomButton(
              text: "enviar",
              onTap: () {
                WebService.send("a", {}, {});
              })
        ],
      ),
    ));
  }

  void initMac() async {}

  String nowDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    final String formatted = formatter.format(now);
    return formatted;
  }

  bool isString(dynamic value) {
    return value is String;
  }

  bool isDouble(dynamic value) {
    return value is Double;
  }

  bool isInteger(dynamic value) {
    return value is int;
  }
}
