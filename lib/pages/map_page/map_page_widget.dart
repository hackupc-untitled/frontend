import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gnss/WebService/WebService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'map_page_model.dart';
export 'map_page_model.dart';

import 'package:latlong2/latlong.dart' as latLng;

class MapPageWidget extends StatefulWidget {
  const MapPageWidget({super.key});

  @override
  State<MapPageWidget> createState() => _MapPageWidgetState();
}

class _MapPageWidgetState extends State<MapPageWidget> {
  Widget flutterMap = FlutterMap(
    options: MapOptions(
      // initialCenter: LatLng(51.509364, -0.128928),
      initialZoom: 9.2,
    ),
    children: [
      RichAttributionWidget(
        attributions: [
          TextSourceAttribution(
            'OpenStreetMap contributors',
            // onTap: () {}
          ),
        ],
      ),
    ],
  );
  late MapPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MapPageModel());
  }

  List<Container> listItems = [];

  @override
  void didChangeDependencies() async {
    await getUserPos();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  getUserPos() async {
    List<Container>? dataWidgets = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("ff_userId") ?? 0;

    List<dynamic> positions = await WebService.getUserPos(userId);
    positions.forEach((element) {
      dataWidgets!.add(Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, //                   <--- border color
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Latitude Degrees -> ${element["LatitudeDegrees"]}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "Longitude Degrees:-> ${element["LongitudeDegrees"]}"),
                    ],
                  ),
                )
              ],
            ),
          )));
    });
    setState(() {
      listItems = dataWidgets!;
      flutterMap = FlutterMap(
        options: MapOptions(
          // initialCenter: (51.509364, -0.128928),
          initialZoom: 0,
        ),
        children: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                // onTap: () {}
              ),
            ],
          ),
        ],
      );
    });
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
              child: ListView(
                  children: [
                        Container(
                          height: 300,
                          child: Padding(
                              padding: EdgeInsets.all(16.0), child: flutterMap),
                        )
                      ] +
                      listItems),
            )));
  }
}
