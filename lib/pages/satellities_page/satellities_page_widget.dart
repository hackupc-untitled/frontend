import 'package:gnss/WebService/WebService.dart';

import '/components/card13_podcast_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'satellities_page_model.dart';
export 'satellities_page_model.dart';

class SatellitiesPageWidget extends StatefulWidget {
  const SatellitiesPageWidget({super.key});

  @override
  State<SatellitiesPageWidget> createState() => _SatellitiesPageWidgetState();
}

class _SatellitiesPageWidgetState extends State<SatellitiesPageWidget> {
  late SatellitiesPageModel _model;
  bool noData = false;

  List<Widget> listData = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedValue = "";

  String comsoletionType = "";
  String time = "";
  String recSVTN = "";
  int svid = 0;
  String acuracity = "";

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SatellitiesPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  updateSatelitInfo(int newsvid) async {
    Map<String, dynamic> data = await WebService.getSatelliteInfo(newsvid);
    print(data);
    setState(() {
      svid = newsvid;
      comsoletionType = data["constellationType"].toString();
      time = data["time"].toString();
      if (data["time"].toString() == null) {
        setState(() {
          noData = true;
        });
      } else {
        setState(() {
          noData = false;
        });
      }
      recSVTN = data["receivedSvTimeNanos"].toString();
      listData = [
        wrapWithModel(
          model: _model.card13PodcastModel1,
          updateCallback: () => setState(() {}),
          child: Card13PodcastWidget(
            title: "SvId",
            value: "${svid}",
          ),
        ),
        wrapWithModel(
          model: _model.card13PodcastModel2,
          updateCallback: () => setState(() {}),
          child: Card13PodcastWidget(
            title: "Last Reciving:",
            value: "${time}",
          ),
        ),
        wrapWithModel(
          model: _model.card13PodcastModel3,
          updateCallback: () => setState(() {}),
          child: Card13PodcastWidget(
            title: "Total Recived Sv Time Nanos",
            value: "${recSVTN}",
          ),
        ),
        wrapWithModel(
          model: _model.card13PodcastModel5,
          updateCallback: () => setState(() {}),
          child: Card13PodcastWidget(
            title: "Constellation Type",
            value: "${comsoletionType}",
          ),
        )
      ];
    });
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 16.0),
                          child: FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController ??=
                                FormFieldController<String>(null),
                            options: [
                              'Satellite 1',
                              'Satellite 2',
                              'Satellite 3',
                              'Satellite 4',
                              'Satellite 5',
                              'Satellite 6',
                              'Satellite 7',
                              'Satellite 8',
                              'Satellite 9',
                              'Satellite 10',
                              'Satellite 11',
                              'Satellite 12',
                              'Satellite 13',
                              'Satellite 14',
                              'Satellite 15',
                              'Satellite 16',
                              'Satellite 17',
                              'Satellite 18',
                              'Satellite 19',
                              'Satellite 20',
                              'Satellite 21',
                              'Satellite 22',
                              'Satellite 23',
                              'Satellite 24',
                              'Satellite 25',
                              'Satellite 26',
                              'Satellite 27',
                              'Satellite 28',
                              'Satellite 29',
                              'Satellite 30',
                              'Satellite 31',
                              'Satellite 32'
                            ],
                            onChanged: (val) async {
                              int svid = int.parse(val!.split(" ")[1]);
                              await updateSatelitInfo(svid);
                              setState(() {
                                selectedValue = val;
                              });
                              setState(() => _model.dropDownValue = val);
                            },
                            width: 300.0,
                            height: 56.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Please select...',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
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
                  selectedValue == ""
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Select a satellite!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            )
                          ],
                        )
                      : noData
                          ? Text(
                              "No data! Please select other satellite",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.max,
                              children: listData),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
