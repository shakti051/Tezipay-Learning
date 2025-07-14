import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> steps = [
    {
      'title': 'Submitted',
      'date': '08 Jun 2025, 10:22',
      'status': 'Pending',
      'color': Colors.grey,
      'icon': Icons.circle,
    },
    {
      'title': 'Initiated',
      'date': '09 Jun 2025, 10:22',
      'status': 'Pending',
      'color': Colors.grey,
      'icon': Icons.circle,
    },
    {
      'title': 'Review',
      'date': '18 Jun 2025, 10:13',
      'status': 'Pending',
      'color': Colors.grey,
      'icon': Icons.circle,
    },
    {
      'title': 'Approve',
      'date': '',
      'status': 'Pending',
      'color': Colors.grey,
      'icon': Icons.circle,
    },
    {
      'title': 'Extra',
      'date': '18 Jun 2025, 10:25',
      'status': 'Pending',
      'color': Colors.grey,
      'icon': Icons.circle,
    },
  ];

  int activeStepIndex = -1;

  double animatedProgress = 0.0;
  late AnimationController _controller;
  late Animation<double> _glowOpacity;

  @override
  void initState() {
    super.initState();
    _startStepProgress();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // repeat blink

    _glowOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _startStepProgress() {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (activeStepIndex <= steps.length) {
        setState(() {
          animatedProgress = 0.0;
        });

        // Animate progress line before updating step
        for (int i = 0; i <= 10; i++) {
          await Future.delayed(const Duration(milliseconds: 400));
          setState(() {
            animatedProgress = i / 10;
          });
        }

        setState(() {
          activeStepIndex++;
          steps[activeStepIndex]['status'] = 'Success';
          if (activeStepIndex + 1 < steps.length) {
            steps[activeStepIndex + 1]['status'] = 'Active';
          }

          steps[activeStepIndex]['color'] = Colors.green;
          steps[activeStepIndex]['icon'] = Icons.check;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Equipment Claim Progress")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(steps.length, (index) {
            final step = steps[index];

            final beforeColor = index == 0
                ? steps[index]['color']
                : Color.lerp(
                    Colors.grey,
                    steps[index - 1]['color'],
                    (activeStepIndex >= index) ? 1.0 : animatedProgress,
                  )!;

            final afterColor = index <= activeStepIndex
                ? Color.lerp(Colors.grey, Colors.green, animatedProgress)!
                : Colors.grey;
            return Row(
              children: [
                TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  isFirst: index == 0,
                  isLast: index == steps.length - 1,
                  beforeLineStyle: LineStyle(color: beforeColor, thickness: 4),
                  afterLineStyle: LineStyle(color: afterColor, thickness: 4),
                  indicatorStyle: IndicatorStyle(
                    width: 40,
                    height: 40,
                  
                    indicator: AnimatedBuilder(
                      animation: _glowOpacity,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: step['status'] == 'Active'
                                ? Border.all(color: Colors.orange, width: 4)
                                : Border.all(color: step['color'], width: 4),
                            boxShadow: step['status'] == 'Active'
                                ? [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(
                                        _glowOpacity.value,
                                      ),
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: step['status'] == 'Success'
                                ? Icon(step['icon'], color: step['color'])
                                : Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: step['color'],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  endChild: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Text(
                          step['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        if (step['date'].isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              step['date'],
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
