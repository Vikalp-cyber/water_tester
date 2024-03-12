import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  // Sample data for demonstration
  List<double> percent = [90.00, 88.00, 91.00, 92.00, 93.00, 94.00];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 27, 30, 60).withOpacity(0.5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: const FlTitlesData(),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.white),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                  percent.length,
                  (index) => FlSpot(index.toDouble(), percent[index]),
                ),
                isCurved: true,
                color: const Color.fromARGB(255, 33, 54, 243),
                barWidth: 2,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
