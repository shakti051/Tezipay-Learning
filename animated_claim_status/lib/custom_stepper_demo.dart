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

  int currentStep = 0;

  final List<_StepData> steps = [
    _StepData("Submitted", "Pending", "06 Jun 2025, 10:22"),
    _StepData("Initiated", "Pending", "07 Jun 2025, 10:22"),
    _StepData("Review", "Pending", "08 Jun 2025, 10:13"),
    _StepData("Approve", "Pending", "09 Jun 2025, 10:23"),
    _StepData("Extra", "Pending", "10 Jun 2025, 10:25"),
  ];

  @override
  void initState() {
    super.initState();

    steps[0].isCurrent = true;

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 4.0,
      end: 12.0,
    ).animate(CurvedAnimation(parent: _glowController, curve: Curves.linear));

    _lineControllers = List.generate(
      steps.length - 1,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      ),
    );

    _lineAnimations = _lineControllers
        .map((c) => Tween<double>(begin: 0.0, end: 1.0).animate(c))
        .toList();

    startAutoProgress();
  }

  void startAutoProgress() async {
    for (int i = 1; i < steps.length; i++) {
      await _lineControllers[i - 1].forward();

      setState(() {
        steps[i - 1]
          ..isCompleted = true
          ..status = "Success"
          ..isCurrent = false
          ..isConnected = true;

        steps[i].isCurrent = true;
        currentStep = i;
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: step.isCompleted ? Colors.green : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: step.isCurrent
                  ? Colors.orange
                  : step.isCompleted
                  ? Colors.green
                  : Colors.grey,
              width: 3,
            ),
            boxShadow: step.isCurrent
                ? [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.5),
                      blurRadius: glowRadius,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: step.isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : Text(
                    step.title[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: step.isCurrent ? Colors.grey[700] : Colors.black,
                    ),
                  ),
          ),
        ),     
      ],
    );
  }

  Widget buildStepStatus(_StepData step) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          step.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          step.status,
          style: TextStyle(
            color: step.status == "Success" ? Colors.green : Colors.orange,
            fontSize: 12,
          ),
        ),
        // Text(
        //   step.timestamp,
        //   style: const TextStyle(fontSize: 10, color: Colors.black54),
        // ),
      ],
    );
  }

  Widget buildAnimatedLine(int index) {
    return AnimatedBuilder(
      animation: _lineAnimations[index],
      builder: (context, child) {
        final progress = _lineAnimations[index].value;
        final isAnimating = progress > 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: isAnimating
              ? CustomPaint(
                  painter: _AnimatedLinePainter(
                    progress: progress,
                    color: progress == 1.0 ? Colors.green : Colors.green,
                  ),
                  child: const SizedBox(height: 4),
                )
              : CustomPaint(
                  painter: _DottedLinePainter(color: Colors.grey),
                  child: const SizedBox(height: 4),
                ),
        );
      },
    );
  }

  Widget buildStepper() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              final lineIndex = index ~/ 2;
              return Expanded(child: buildAnimatedLine(lineIndex));
            } else {
              final step = steps[index ~/ 2];
              final isGlowing = step.isCurrent && (index ~/ 2 == currentStep);
              return buildStepItem(step, isGlowing ? _glowAnimation.value : 0);
            }
          }),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(steps.length * 2 - 1, (index) {
            if (index.isOdd) {
              final lineIndex = index ~/ 2;
              return Expanded(
                child: Opacity(opacity: 0, child: buildAnimatedLine(lineIndex)),
              );
            } else {
              final step = steps[index ~/ 2];

              return buildStepStatus(step);
            }
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
  String status;
  bool isCompleted;
  bool isConnected;
  bool isCurrent;

  _StepData(
    this.title,
    this.status,
    this.timestamp, [
    this.isCompleted = false,
    this.isConnected = false,
    this.isCurrent = false,
  ]);
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

    final double lineLength = size.width * progress;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(lineLength, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _AnimatedLinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
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
