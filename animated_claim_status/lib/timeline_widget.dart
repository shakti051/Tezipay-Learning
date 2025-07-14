
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Stage {
  final String id;
  final String name;
  final String status; // "success" or "pending"
  final String? delay;
  final DateTime? date;

  Stage({
    required this.id,
    required this.name,
    required this.status,
    this.delay,
    this.date,
  });
}

class TimelineWidget extends StatefulWidget {
  final String title;
  final List<Stage> stages;
  final String successLabel;
  final String pendingLabel;
  final String refreshLabel;
  final String historyLabel;
  final VoidCallback? onRefresh;
  final VoidCallback? onViewHistory;

  const TimelineWidget({
    super.key,
    required this.title,
    required this.stages,
    this.successLabel = 'Success',
    this.pendingLabel = 'Pending',
    this.refreshLabel = 'Refresh',
    this.historyLabel = 'View Status History',
    this.onRefresh,
    this.onViewHistory,
  });

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _lineControllers;
  late List<AnimationController> _glowControllers;
  late List<bool> _showDashedLine;
  late List<String> _stageStyles; // "gray", "green", "orange"
  int firstPendingIndex = -1;
  int lastSuccessIndex = -1;

  @override
  void initState() {
    super.initState();
    _initStates();
    _runAnimations();
  }

  void _initStates() {
    int n = widget.stages.length;

    _showDashedLine = List.generate(n - 1, (_) => true);
    _stageStyles = List.generate(n, (_) => 'gray');
    firstPendingIndex = -1;
    lastSuccessIndex = -1;

    for (int i = 0; i < n; i++) {
      if (widget.stages[i].status.toLowerCase() == 'success') {
        lastSuccessIndex = i;
      } else if (widget.stages[i].status.toLowerCase() == 'pending' &&
          firstPendingIndex == -1) {
        firstPendingIndex = i;
      }
    }

    _lineControllers = List.generate(
        n - 1,
        (_) => AnimationController(
            vsync: this, duration: const Duration(milliseconds: 1000)));
    _glowControllers = List.generate(
        n,
        (_) => AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1500),
            reverseDuration: const Duration(milliseconds: 1500)));
  }

  Future<void> _runAnimations() async {
    // Set initial stage 0 to green with glow
    setState(() {
      _stageStyles[0] = 'greenGlowTemp';
    });

    // Wait 0.5s for glow animation
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _stageStyles[0] = 'greenGlow';
    });

    // Animate each success connector and stage
    for (int i = 1; i <= lastSuccessIndex; i++) {
      await _lineControllers[i - 1].forward();
      setState(() {
        _showDashedLine[i - 1] = false;
        _stageStyles[i] = 'greenGlowTemp';
      });
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _stageStyles[i] = 'greenGlow';
      });
    }

    // Animate first pending stage
    if (firstPendingIndex != -1) {
      if (lastSuccessIndex < widget.stages.length - 1 && lastSuccessIndex >= 0) {
        await _lineControllers[lastSuccessIndex].forward();
        setState(() {
          _showDashedLine[lastSuccessIndex] = false;
          _stageStyles[firstPendingIndex] = 'orangeGlow';
        });
        _glowControllers[firstPendingIndex].repeat(reverse: true);
      } else if (lastSuccessIndex == -1) {
        // No success stages, just glow on first pending
        setState(() {
          _stageStyles[firstPendingIndex] = 'orangeGlow';
        });
        _glowControllers[firstPendingIndex].repeat(reverse: true);
      }
    }
  }

  @override
  void dispose() {
    for (var c in _lineControllers) {
      c.dispose();
    }
    for (var c in _glowControllers) {
      c.dispose();
    }
    super.dispose();
  }

  String formatStatus(String status) {
    if (status.toLowerCase() == 'success') return widget.successLabel;
    return widget.pendingLabel;
  }

  String formatDate(DateTime date) {
    return DateFormat("dd MMM yyyy, HH:mm").format(date);
  }

  BoxDecoration _stageDecoration(int index) {
    switch (_stageStyles[index]) {
      case 'greenGlowTemp':
        return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.green.shade500, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.green.shade400,
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        );
      case 'greenGlow':
        return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.green.shade500, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.green.shade400,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        );
      case 'orangeGlow':
        return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.orange.shade400, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade300,
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        );
      case 'gray':
      default:
        return BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade400, width: 4),
        );
    }
  }

  Widget _buildConnector(int index) {
    if (_showDashedLine[index]) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          height: 4,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey.shade300,
                width: 4,
                style: BorderStyle.solid, // Flutter doesn't support dashed out of box, could use a dashed package if needed
              ),
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: AnimatedBuilder(
          animation: _lineControllers[index],
          builder: (context, child) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width:
                    (MediaQuery.of(context).size.width / (widget.stages.length * 1.1)) *
                        _lineControllers[index].value,
                height: 4,
                color: Colors.green.shade500,
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildStageCircle(int index) {
    bool isSuccess =
        widget.stages[index].status.toLowerCase() == 'success' && _stageStyles[index].startsWith('green');
    return AnimatedBuilder(
      animation: _glowControllers[index],
      builder: (context, child) {
        BoxShadow? glow;
        if (_stageStyles[index] == 'orangeGlow') {
          double glowVal = 10 + 15 * _glowControllers[index].value;
          glow = BoxShadow(
            color: Colors.orange.shade300.withOpacity(0.6),
            blurRadius: glowVal,
            spreadRadius: glowVal / 4,
          );
        } else if (_stageStyles[index] == 'greenGlow') {
          double glowVal = 5 + 10 * _glowControllers[index].value;
          glow = BoxShadow(
            color: Colors.green.shade400.withOpacity(0.6),
            blurRadius: glowVal,
            spreadRadius: glowVal / 4,
          );
        }
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _stageStyles[index] == 'gray'
                  ? Colors.grey.shade400
                  : _stageStyles[index] == 'orangeGlow'
                      ? Colors.orange.shade400
                      : Colors.green.shade500,
              width: 4,
            ),
            boxShadow: glow != null ? [glow] : null,
          ),
          alignment: Alignment.center,
          child: isSuccess
              ? const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF50CD1B),
                  size: 28,
                )
              : Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _stageStyles[index] == 'gray'
                        ? Colors.grey.shade500
                        : _stageStyles[index] == 'orangeGlow'
                            ? Colors.orange.shade400
                            : Colors.green.shade500,
                  ),
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final stages = widget.stages;
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  )),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: widget.onViewHistory,
                    icon: const Icon(Icons.history, color: Colors.green),
                    label: Text(widget.historyLabel,
                        style: const TextStyle(color: Colors.green)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      backgroundColor: Colors.green.shade50,
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: widget.onRefresh,
                    icon: const Icon(Icons.refresh, color: Colors.green),
                    label: Text(widget.refreshLabel,
                        style: const TextStyle(color: Colors.green)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      backgroundColor: Colors.green.shade50,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Timeline Steps
          SizedBox(
            height: 130,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(stages.length * 2 - 1, (i) {
                if (i.isOdd) {
                  // Connector between stages
                  int connectorIndex = (i ~/ 2);
                  return _buildConnector(connectorIndex);
                } else {
                  // Stage item
                  int stageIndex = i ~/ 2;
                  final stage = stages[stageIndex];

                  return SizedBox(
                    width: MediaQuery.of(context).size.width / (stages.length * 1.1),
                    child: Column(
                      children: [
                        if (stage.delay != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              stage.delay!,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        _buildStageCircle(stageIndex),
                        const SizedBox(height: 6),
                        Text(stage.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: stage.status.toLowerCase() == 'success'
                                ? Colors.green.shade100
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(formatStatus(stage.status),
                              style: TextStyle(
                                fontSize: 11,
                                color: stage.status.toLowerCase() == 'success'
                                    ? Colors.green.shade700
                                    : Colors.grey.shade600,
                              )),
                        ),
                        if (stage.date != null)
                          Text(formatDate(stage.date!),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              )),
                      ],
                    ),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
