import 'package:flutter/material.dart';

class CustomStepperDemo extends StatefulWidget {
  const CustomStepperDemo({super.key});

  @override
  State<CustomStepperDemo> createState() => _CustomStepperDemoState();
}

class _CustomStepperDemoState extends State<CustomStepperDemo>
    with TickerProviderStateMixin {
  late final AnimationController _glowController;
  late final Animation<double> _glowAnimation;

  late final List<AnimationController> _lineControllers;
  late final List<Animation<double>> _lineAnimations;

  int currentStep = 1;

  final List<_StepData> steps = [
    _StepData("Submitted", "Success", 1,"06 Jun 2025, 10:22",),
    _StepData("Initiated", "Success", 2,"07 Jun 2025, 10:22"),
    _StepData("Review", "Pending", 3,"08 Jun 2025, 10:13"),
    _StepData("Approve", "Pending", 4,"09 Jun 2025, 10:23"),
    _StepData("Extra", "Pending", 5,"10 Jun 2025, 10:25"),
  ];

  @override
  void initState() {
    super.initState();

    steps[0].isCompleted = true;
    steps[1].isCurrent = true;

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 4.0,
      end: 12.0,
    ).animate(CurvedAnimation(parent: _glowController, curve: Curves.linear));

    _lineControllers = List.generate(
      steps.length - 1,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      ),
    );

    _lineAnimations = _lineControllers
        .map((c) => Tween<double>(begin: 0.0, end: 1.0).animate(c))
        .toList();

    startAutoProgress();
  }

  void startAutoProgress() async {
    for (int i = 0; i < _lineControllers.length; i++) {
      // Stop if next step is pending
      if (steps[i + 1].status.toLowerCase() == 'pending') {
        await _lineControllers[i].forward();
        setState(() {
          steps[i + 1]
            ..isCurrent = true
            ..isGlowingOrange = true;
          currentStep = i + 1;
        });
        break;
      }

      await _lineControllers[i].forward();

      setState(() {
        steps[i + 1]
          ..isCompleted = true
          ..isCurrent = false
          ..isGlowingGreen = true;

        if (i + 2 < steps.length) {
          steps[i + 2].isCurrent = true;
          currentStep = i + 2;
        }
      });

      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        steps[i + 1].isGlowingGreen = false;
      });
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    for (final controller in _lineControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget buildStepItem(_StepData step, double glowRadius) {
    Color borderColor = Colors.grey;
    Color backgroundColor = step.isCompleted
        ? Colors.white
        : Colors.grey.shade400;

    if (step.isGlowingGreen) {
      borderColor = Colors.green;
    } else if (step.isGlowingOrange) {
      borderColor = Colors.orange;
      backgroundColor = Colors.white;
    } else if (step.isCompleted) {
      borderColor = Colors.green;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 3),
        boxShadow: step.isGlowingGreen || step.isGlowingOrange
            ? [
                BoxShadow(
                  color: step.isGlowingGreen
                      ? Colors.green.withOpacity(0.6)
                      : Colors.orange.withOpacity(0.6),
                  blurRadius: glowRadius,
                  spreadRadius: 3,
                ),
              ]
            : [],
      ),
      child: Center(
        child: step.isCompleted
            ? const Icon(Icons.check, color: Colors.green, size: 20)
            : Text(
                step.index.toString(),
                 style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: step.isCurrent ? Colors.grey[700] : Colors.black
                ),
              ),
      ),
    );
  }

  Widget buildStepStatus(_StepData step) {
    return Column(
      children: [
        Text(step.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: step.status == "Success"
                ? const Color.fromARGB(80, 69, 254, 81)
                : Color.fromARGB(255, 208, 208, 208),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            step.status,
            style: TextStyle(
              color: step.status == "Success" ? Colors.green : Colors.black38,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStepDateTime(_StepData step) {
    return Text(step.timestamp, style: const TextStyle(fontSize: 12));
  }

  Widget buildAnimatedLine(int index) {
    return AnimatedBuilder(
      animation: _lineAnimations[index],
      builder: (context, child) {
        final progress = _lineAnimations[index].value;
        return SizedBox(
          height: 4,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _DottedLinePainter(color: Colors.grey),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(
                  painter: _AnimatedLinePainter(
                    progress: progress,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildStepper() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) return const Expanded(child: SizedBox());
            return buildStepStatus(steps[index ~/ 2]);
          }),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              return Expanded(child: buildAnimatedLine(index ~/ 2));
            } else {
              final step = steps[index ~/ 2];
              final isGlowing = step.isCurrent && (index ~/ 2 == currentStep);
              return buildStepItem(
                step,
                isGlowing || step.isGlowingGreen || step.isGlowingOrange
                    ? _glowAnimation.value
                    : 0,
              );
            }
          }),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) return const Expanded(child: SizedBox());
            return buildStepDateTime(steps[index ~/ 2]);
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      appBar: AppBar(title: const Text("Custom Stepper")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Initiator IT Equipment Claim",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.history, size: 18),
                  label: const Text("View Status History"),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text("Refresh"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            buildStepper(),
          ],
        ),
      ),
    );
  }
}

class _StepData {
  final String title;
  final String timestamp;
  int index;
  String status;
  bool isCompleted;
  bool isCurrent;
  bool isGlowingGreen;
  bool isGlowingOrange;

  _StepData(
    this.title,
    this.status,
    this.index,
    this.timestamp, {
    this.isCompleted = false,
    this.isCurrent = false,
    this.isGlowingGreen = false,
    this.isGlowingOrange = false,
  });
}

class _AnimatedLinePainter extends CustomPainter {
  final double progress;
  final Color color;

  _AnimatedLinePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width * progress, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _AnimatedLinePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpacing;

  _DottedLinePainter({
    required this.color,
    this.dashWidth = 6,
    this.dashSpacing = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
