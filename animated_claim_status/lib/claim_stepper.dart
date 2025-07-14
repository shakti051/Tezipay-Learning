import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ClaimStepper extends StatelessWidget {
  final List<StepData> steps = [
    StepData('Submitted', '08 Jun 2025, 10:22', StepStatus.success),
    StepData('Initiated', '09 Jun 2025, 10:22', StepStatus.success),
    StepData('Review', '18 Jun 2025, 10:13', StepStatus.success),
    StepData('Approve', '', StepStatus.pending, number: '4'),
    StepData('Extra', '18 Jun 2025, 10:25', StepStatus.pending, number: '5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Initiator IT Equipment Claim',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isOdd) {
                final isDashed = steps[(index ~/ 2) + 1].status == StepStatus.pending;
                return CustomPaint(
                  size: Size(40, 2),
                  painter: StepLinePainter(isDashed: isDashed),
                );
              } else {
                final step = steps[index ~/ 2];
                return _buildStep(step);
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildStep(StepData step) {
    final bool isSuccess = step.status == StepStatus.success;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSuccess ? Colors.green : Colors.white,
                border: Border.all(
                  color: isSuccess ? Colors.green : Colors.orange,
                  width: 2,
                ),
                boxShadow: step.status == StepStatus.pending
                    ? [BoxShadow(color: Colors.orange.withOpacity(0.5), blurRadius: 10)]
                    : [],
              ),
              child: Center(
                child: isSuccess
                    ? Icon(Icons.check, color: Colors.white)
                    : Text(step.number ?? '?', style: TextStyle(color: Colors.orange)),
              ),
            ),
            if (step.status == StepStatus.pending)
              Positioned(
                top: -20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Pending', style: TextStyle(fontSize: 12)),
                ),
              ),
            if (step.status == StepStatus.success)
              Positioned(
                top: -20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('Success', style: TextStyle(fontSize: 12, color: Colors.green)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(step.title, style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 2),
        if (step.timestamp.isNotEmpty)
          Text(step.timestamp, style: TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}

class StepData {
  final String title;
  final String timestamp;
  final StepStatus status;
  final String? number;

  StepData(this.title, this.timestamp, this.status, {this.number});
}

enum StepStatus { success, pending }

class StepLinePainter extends CustomPainter {
  final bool isDashed;

  StepLinePainter({required this.isDashed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDashed ? Colors.grey : Colors.green
      ..strokeWidth = 2;

    if (isDashed) {
      double dashWidth = 5, dashSpace = 3, startX = 0;
      while (startX < size.width) {
        canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
        startX += dashWidth + dashSpace;
      }
    } else {
      canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
