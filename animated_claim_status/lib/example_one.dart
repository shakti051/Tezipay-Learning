import 'package:flutter/material.dart';
import 'package:step_progress/step_progress.dart';

class ExampleOne extends StatefulWidget {
  const ExampleOne({super.key});

  @override
  State<ExampleOne> createState() => _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOne> {
  final StepProgressController stepProgressController = StepProgressController(
    totalSteps: 5,
  );

  @override
  void initState() {
    super.initState();
    completeProcessAutomatic();
  }

  completeProcessAutomatic() {
    Future.delayed(Duration(seconds: 2), () {
      if (stepProgressController.currentStep < 5) {
        stepProgressController.nextStep();
        completeProcessAutomatic();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StepProgress - vertical')),
      body: SingleChildScrollView(
        
        child: SafeArea(
          child: Column(
            
            spacing: 48,
            children: [
              StepProgress(
                totalSteps: 5,
                controller: stepProgressController,
                axis: Axis.vertical,
                nodeTitles: const ['Submit',
                'Initiated',
                'Review',
                'Approve',
                'Extra'
                ],
                nodeSubTitles: [
                '10:20 PM',
                '11:30 AM',
                '09:20 PM',
                '08:20 PM',
                
              ],
               lineSubTitles: [
                 'Dec 20, 2025',
                 'Dec 21, 2025',
                 'Dec 22, 2025',
                 'Dec 23, 2025',
               ],
                onStepChanged: (index) {
                  debugPrint('on step changed: $index');
                },
                onStepNodeTapped: (index) {
                  debugPrint('on step tapped with index: $index');
                },
                onStepLineTapped: (index) {
                  debugPrint('on step line tapped with index: $index');
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 38,
                children: [
                  ElevatedButton(
                    onPressed: stepProgressController.previousStep,
                    child: const Text('Prev'),
                  ),
                  ElevatedButton(
                    onPressed: stepProgressController.nextStep,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
