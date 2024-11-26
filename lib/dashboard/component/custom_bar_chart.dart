import 'package:dimple/common/const/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

enum ChartPeriod { day, week, month, year }

class CustomBarChart extends StatefulWidget {
  final ChartPeriod period;

  const CustomBarChart({
    super.key,
    required this.period,
  });

  @override
  State<CustomBarChart> createState() => CustomBarChartState();
}

class CustomBarChartState extends State<CustomBarChart> {
  late List<ChartDataModel> chartData;

  @override
  void initState() {
    super.initState();
    updateChartData();
  }

  @override
  void didUpdateWidget(CustomBarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.period != widget.period) {
      updateChartData();
    }
  }

  void updateChartData() {
    switch (widget.period) {
      case ChartPeriod.day:
        chartData = getDayData();
      case ChartPeriod.week:
        chartData = getWeekData();
      case ChartPeriod.month:
        chartData = getMonthData();
      case ChartPeriod.year:
        chartData = getYearData();
    }
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    final index = value.toInt();
    String text = '';

    // 기간별로 다른 레이블 로직 적용
    switch (widget.period) {
      case ChartPeriod.day:
      // 6시간 간격으로만 레이블 표시
        if (index % 6 == 0) {
          final hour = index ~/ 2;
          if (hour == 0) text = '오전 12시';
          else if (hour == 6) text = '6시';
          else if (hour == 12) text = '오후 12시';
          else if (hour == 18) text = '6시';
        }
      case ChartPeriod.week:
      // 모든 요일 표시
        final days = ['월', '화', '수', '목', '금', '토', '일'];
        text = days[index];
      case ChartPeriod.month:
      // 주차 표시
        text = '${index + 1}주';
      case ChartPeriod.year:
      // 월 표시
        final months = ['1월', '4월', '7월', '10월'];
        if (index % 3== 0) {
          text = months[index ~/ 3];
        }
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
    const style = TextStyle(fontSize: 10);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        formatValue(value),
        style: style,
      ),
    );
  }

  String formatValue(double value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    }
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(1);
  }

  double getBarWidth() {
    switch (widget.period) {
      case ChartPeriod.day:
        return 8.0; // 24시간 데이터
      case ChartPeriod.week:
        return 20.0; // 7일 데이터
      case ChartPeriod.month:
        return 30.0; // 4주 데이터
      case ChartPeriod.year:
        return 15.0; // 12개월 데이터
    }
  }

  double getBarsSpace() {
    switch (widget.period) {
      case ChartPeriod.day:
        return 12.0; // 24시간 데이터
      case ChartPeriod.week:
        return 25.0; // 7일 데이터
      case ChartPeriod.month:
        return 40.0; // 4주 데이터
      case ChartPeriod.year:
        return 20.0; // 12개월 데이터
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(enabled: false),
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
                  horizontalInterval: 1000000000,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                  // 1000000000
                  drawVerticalLine: true,
                  verticalInterval: 1000000000,
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                groupsSpace: getBarsSpace(),
                barGroups: chartData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.value,
                        rodStackItems: [
                          BarChartRodStackItem(0, entry.value.value, PRIMARY_COLOR),
                        ],
                        borderRadius: BorderRadius.zero,
                        width: getBarWidth(),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  List<ChartDataModel> getDayData() {
    return List.generate(24, (i) {
      return ChartDataModel(
        value: (0 + (i * 100000000 * (i % 3 == 0 ? 2 : 1))).toDouble(),
        label: '',
      );
    });
  }

  List<ChartDataModel> getWeekData() {
    return List.generate(7, (i) => ChartDataModel(
      value: (5000000000 + (i * 1000000000)).toDouble(),
      label: '',
    ));
  }

  List<ChartDataModel> getMonthData() {
    return List.generate(4, (i) => ChartDataModel(
      value: (8000000000 + (i * 2000000000)).toDouble(),
      label: '',
    ));
  }

  List<ChartDataModel> getYearData() {
    return List.generate(12, (i) => ChartDataModel(
      value: (10000000000 + (i * 1000000000)).toDouble(),
      label: '',
    ));
  }
}

class ChartDataModel {
  final double value;
  final String label;

  ChartDataModel({required this.value, required this.label});
}