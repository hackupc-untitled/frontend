import '/components/card13_podcast_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'satellities_page_widget.dart' show SatellitiesPageWidget;
import 'package:flutter/material.dart';

class SatellitiesPageModel extends FlutterFlowModel<SatellitiesPageWidget> {
  ///  State fields for stateful widgets in this page.
  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for Card13Podcast component.
  late Card13PodcastModel card13PodcastModel1;
  // Model for Card13Podcast component.
  late Card13PodcastModel card13PodcastModel2;
  // Model for Card13Podcast component.
  late Card13PodcastModel card13PodcastModel3;
  // Model for Card13Podcast component.
  late Card13PodcastModel card13PodcastModel4;
  // Model for Card13Podcast component.
  late Card13PodcastModel card13PodcastModel5;
  // Model for Card13Podcast component.
  late Card13PodcastModel card13PodcastModel6;

  @override
  void initState(BuildContext context) {
    card13PodcastModel1 = createModel(context, () => Card13PodcastModel());
    card13PodcastModel2 = createModel(context, () => Card13PodcastModel());
    card13PodcastModel3 = createModel(context, () => Card13PodcastModel());
    card13PodcastModel4 = createModel(context, () => Card13PodcastModel());
    card13PodcastModel5 = createModel(context, () => Card13PodcastModel());
    card13PodcastModel6 = createModel(context, () => Card13PodcastModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    card13PodcastModel1.dispose();
    card13PodcastModel2.dispose();
    card13PodcastModel3.dispose();
    card13PodcastModel4.dispose();
    card13PodcastModel5.dispose();
    card13PodcastModel6.dispose();
  }
}
