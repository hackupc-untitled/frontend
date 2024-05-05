import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LineChartCustom extends StatefulWidget {
  final List<dynamic> data;
  const LineChartCustom({super.key, required this.data});

  @override
  State<LineChartCustom> createState() => _LineChartState();
}

class _LineChartState extends State<LineChartCustom> {
  double index = 0;
  List<FlSpot> generatedata() {
    List<FlSpot> dateFl = [];
    widget.data.forEach((element) {
      dateFl.add(FlSpot(index, element["data"].toDouble()));
      index++;
    });
    return dateFl;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Container(
          height: 400,
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                // The red line
                LineChartBarData(
                  spots: generatedata(),
                  isCurved: true,
                  barWidth: 3,
                  color: Colors.blue,
                ),

                // The orange line
              ],
            ),
          ),
        ));
  }
}
