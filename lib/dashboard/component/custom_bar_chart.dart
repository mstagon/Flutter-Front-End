import 'package:dimple/common/const/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatefulWidget {
  CustomBarChart({super.key});

  final Color chartColor = PRIMARY_COLOR;

  @override
  State<StatefulWidget> createState() => CustomBarChartState();
}

class CustomBarChartState extends State<CustomBarChart> {
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '오전 12시';
        break;
      case 1:
        text = '6시';
        break;
      case 2:
        text = '오후 12시';
        break;
      case 3:
        text = '6시';
        break;
      case 4:
        text = '0';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final barsSpace = 6.0 * constraints.maxWidth / 400;
            final barsWidth = 9.0 * constraints.maxWidth / 400;
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(
                  enabled: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  horizontalInterval: 10000000000, // 가로선 간격 (데이터에 맞게 조정)
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2), // 가로선 색상
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: true, // 세로선 활성화
                  verticalInterval: 1, // 세로선 간격
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2), // 세로선 색상
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: barsSpace,
                barGroups: getData(barsWidth, barsSpace),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 2000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 13000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 13000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 6000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000.5, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 9000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 9000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 2000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 2000000000.5, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 11000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 11000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 14000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 14000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 8000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 8000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 6000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000.5, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 9000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 9000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 6000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 7000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 7000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 1000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 1000000000.5, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 4000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 4000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 4000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 4000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 1000000000.5,
            rodStackItems: [
              BarChartRodStackItem(0, 1000000000.5, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 7000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 7000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 6000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 6000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 9000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 9000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: 7000000000,
            rodStackItems: [
              BarChartRodStackItem(0, 7000000000, widget.chartColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
  }
}
