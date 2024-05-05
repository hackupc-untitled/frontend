import 'dart:async';
import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raw_gnss/raw_gnss.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Data.dart';
import '../../WebService/WebService.dart';
import '../../components/linechart.dart';
import '../../flutter_flow/flutter_flow_drop_down.dart';
import '../../flutter_flow/form_field_controller.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'main_page_model.dart';
export 'main_page_model.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget>
    with TickerProviderStateMixin {
  bool isPersonSelected = false;
  bool isPersonsSelected = false;
  late MainPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};
  bool _hasPermissions = false;
  Timer? timer;

  Widget lineChart = Container();

  @override
  void initState() {
    _model = createModel(context, () => MainPageModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(40.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(40.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(40.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 50.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(40.0, 0.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
    startReading();
    _getCurrentPosition();
    _getGalieos();
    timer = Timer.periodic(
        Duration(seconds: 15), (Timer t) => _getCurrentPosition());
  }

  String galileos = "";
  _getGalieos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("ff_userId") ?? 0;
    Map<String, dynamic> newGalileos = await WebService.getGalileos(userId);
    print("new: ${newGalileos.toString()}");
    setState(() {
      galileos = newGalileos["count"].toString();
    });
  }

  late Position _currentPosition;
  Future<void> _getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("ff_userId") ?? 0;
    _currentPosition = position;
    Map<String, dynamic> data = {
      'LongitudeDegrees': _currentPosition.longitude.toString(),
      'LatitudeDegrees': _currentPosition.latitude.toString(),
      'SpeedMps': _currentPosition.speed.toString(),
      'SpeedAccuracyMps': _currentPosition.speed.toString(),
      'AccuracyMeters': _currentPosition.accuracy.toString(),
      'AltitudeMeters': _currentPosition.altitude.toString()
    };
    WebService.send("fix", data, {}, userId);
  }

  void startReading() {
    DateTime lastDate = DateTime.now();

    RawGnss().gnssMeasurementEvents.listen((e) async {
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
        tags['mac-address'] = getMapDeviceInfo();
        tags["date"] = nowDate();
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt("ff_userId") ?? 0;
      WebService.send("raw", tags, fields, userId);
    });

    RawGnss().gnssNavigationMessageEvents.listen((e) {
      print("navigation");
      print(e.string.toString());
    });

    RawGnss().gnssStatusEvents.listen((e) {
      DateTime nowDateA = DateTime.now();
      if (nowDateA.difference(lastDate).inSeconds >= 10) {
        lastDate = DateTime.now();
        e.status?.forEach((element) async {
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
          Map<String, dynamic> fields = {};
          Map<String, dynamic> tags = {};
          tags["satelliteCount"] = e.satelliteCount;
          data.forEach((key, value) {
            if (isString(value)) {
              tags[key] = value;
            } else if (isDouble(value) || isInteger(value)) {
              fields[key] = value;
            }
          });
          tags['mac-address'] = getMapDeviceInfo();
          tags["date"] = nowDate();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          int userId = prefs.getInt("ff_userId") ?? 0;
          WebService.send("status", tags, fields, userId);
        });
      }
    });
    Permission.location
        .request()
        .then((value) => setState(() => _hasPermissions = value.isGranted));
  }

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

  Map<String, dynamic> getMapDeviceInfo() {
    Map<String, dynamic> data = {
      'version': Data.deviceInfo?.version.codename ?? "",
      'board': Data.deviceInfo?.board ?? "",
      'bootloader': Data.deviceInfo?.bootloader ?? "",
      'brand': Data.deviceInfo?.brand ?? "",
      'device': Data.deviceInfo?.device ?? "",
      'display': Data.deviceInfo?.display ?? "",
      'fingerprint': Data.deviceInfo?.fingerprint ?? "",
      'hardware': Data.deviceInfo?.hardware ?? "",
      'host': Data.deviceInfo?.host ?? "",
      'id': Data.deviceInfo?.id ?? "",
      'manufacturer': Data.deviceInfo?.manufacturer ?? "",
      'model': Data.deviceInfo?.model ?? "",
      'product': Data.deviceInfo?.product ?? "",
    };
    return data;
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xADCFDAFB),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 0.0),
                          child: Container(
                            width: 194.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Galielo Contribution',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 110.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 8.0, 0.0, 0.0),
                                  child: Text(
                                    'Satellite Used:',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .override(
                                          fontFamily: 'Outfit',
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 8.0, 0.0, 0.0),
                                  child: Text(
                                    '${galileos}',
                                    style: FlutterFlowTheme.of(context)
                                        .headlineLarge
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ],
                            ).animateOnPageLoad(
                                animationsMap['columnOnPageLoadAnimation1']!),
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation1']!),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 0.0),
                        child: FlutterFlowDropDown<String>(
                          controller: _model.dropDownValueController ??=
                              FormFieldController<String>(null),
                          options: const [
                            'speedMps',
                            'accuracyMeters',
                            'latitudeDegrees',
                            'longitudeDegrees',
                            'speedAccuracyMps'
                          ],
                          onChanged: (val) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            int userId = prefs.getInt("ff_userId") ?? 0;
                            List<dynamic> listDB =
                                await WebService.getGrafic("fix", val!, userId);
                            print(listDB.toString());
                            setState(() {
                              lineChart = LineChartCustom(data: listDB);
                            });
                            setState(() => _model.dropDownValue = val);
                          },
                          width: 300.0,
                          height: 56.0,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          hintText: 'Please select...',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 2.0,
                          borderRadius: 8.0,
                          margin: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 4.0, 16.0, 4.0),
                          hidesUnderline: true,
                          isOverButton: true,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 0.0),
                          child: Container(
                            width: 194.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  'Graphic information',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 410.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: lineChart,
                                )
                              ],
                            ).animateOnPageLoad(
                                animationsMap['columnOnPageLoadAnimation4']!),
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation4']!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
